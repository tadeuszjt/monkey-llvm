{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler where

import Data.Function
import Data.List
import Data.Either
import Data.Char
import qualified Data.Map as Map
import Control.Monad.State
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Short as BSS

import qualified LLVM.AST as LL
import qualified LLVM.AST.Type as LL
import qualified LLVM.AST.Global as LL
import qualified LLVM.AST.Name as LL
import qualified LLVM.AST.Instruction as LL
import qualified LLVM.AST.Constant as LLC
import qualified LLVM.AST.Linkage as LL
import qualified LLVM.AST.AddrSpace as LL
import qualified LLVM.AST.AddrSpace as LL
import qualified LLVM.AST.CallingConvention as LL

import Lexer as L
import AST as S
import qualified SymTab 


local = LL.LocalReference 
global = LLC.GlobalReference
cons = LL.ConstantOperand


compileAST :: AST -> CmpState
compileAST ast =
	execState (getCmp $ cmpAST ast) initCmpState


type Names = Map.Map Name Int

uniqueName :: Name -> Names -> (Name, Names)
uniqueName name names =
	case Map.lookup name names of
		Just x  -> (name ++ show x, Map.insert name (x+1) names)
		Nothing -> (name, Map.insert name 1 names)


data BlockState
	= BlockState
		{ idx   :: Int
		, stack :: [LL.Named LL.Instruction]
		, term  :: Maybe (LL.Named LL.Terminator)
		}
	deriving (Show)


data FnState
	= FnState
		{ unCount   :: Word
		, symTab    :: SymTab.SymTab Name LL.Operand
		, curBlock  :: LL.Name
		, blocks    :: Map.Map LL.Name BlockState
		, names     :: Names
		, constants :: Map.Map LL.Name LLC.Constant
		}
	deriving (Show)


-- Cmp state
data CmpState
	= CmpState
		{ funcs :: Map.Map LL.Name FnState
		, curFn :: LL.Name
		}
	deriving (Show)


newtype Cmp a
	= Cmp { getCmp :: State CmpState a }
	deriving (Functor, Applicative, Monad, MonadState CmpState)


initBlockState = BlockState 0 [] Nothing


initFnState = FnState
	{ unCount   = 0
	, symTab    = SymTab.initSymTab
	, curBlock  = LL.mkName "entry"
	, blocks    = Map.singleton (LL.mkName "entry") initBlockState
	, names     = Map.singleton "entry" 0
	, constants = Map.empty
	}


initCmpState = CmpState
	{ funcs = Map.singleton (LL.mkName "main") initFnState
	, curFn = LL.mkName "main"
	}


cmpAST :: AST -> Cmp ()
cmpAST ast = do
	setTerminator $ LL.Do $ LL.Ret Nothing []
	mapM_ stmt ast
	--puts "benis"
	return ()


-- Functions
getCurFn :: Cmp FnState
getCurFn = do
	name <- gets curFn
	fns <- gets funcs
	return $ (Map.!) fns name 


modifyCurFn :: (FnState -> FnState) -> Cmp ()
modifyCurFn f = do
	name <- gets curFn
	fns <- gets funcs
	let fn = (Map.!) fns name 
	modify $ \s -> s { funcs = Map.insert name (f fn) (funcs s) }


addConstant :: Name -> LLC.Constant -> Cmp LL.Name
addConstant name cons = do
	LL.Name curFnName <- gets curFn
	fn <- getCurFn

	let (name', names') = uniqueName name (names fn)
	let consName = LL.mkName $ (BS.unpack $ BSS.fromShort curFnName) ++ "." ++ name'

	modifyCurFn $ \f -> f { constants = Map.insert consName cons (constants f), names = names' }
	return consName


-- Blocks
modifyCurBlock :: (BlockState -> BlockState) -> Cmp ()
modifyCurBlock f = do
	fn <- getCurFn
	let blks = blocks fn
	let curBlk = (Map.!) blks (curBlock fn)
	modifyCurFn $ \fn -> fn { blocks = Map.insert (curBlock fn) (f curBlk) blks }
	

setTerminator :: LL.Named LL.Terminator -> Cmp ()
setTerminator term =
	modifyCurBlock $ \b -> b { term = Just term }


-- Names
unName :: Name -> Cmp Name
unName name = do
	fn <- getCurFn
	let (name', names') = uniqueName name (names fn)
	modifyCurFn $ \fn -> fn { names = names'}
	return name'


lookupName :: Name -> Cmp (Maybe LL.Operand)
lookupName name = do
	fn <- getCurFn
	return $ SymTab.lookup name (symTab fn)


unique :: Cmp LL.Name
unique = do
	fn <- getCurFn
	let count = (unCount fn) + 1
	modifyCurFn $ \fn -> fn { unCount = count }
	return $ LL.UnName count


-- Instructions
instr :: LL.Named LL.Instruction -> Cmp ()
instr ins =
	modifyCurBlock $ \b -> b { stack = ins : (stack b) }


typeOf :: LL.Operand -> LL.Type
typeOf (LL.ConstantOperand (LLC.Int 32 _))  = LL.i32
typeOf (LL.ConstantOperand (LLC.Array t a)) = LL.ArrayType (fromIntegral $ length a) t
typeOf (LL.LocalReference t _)              = t


stmt :: Stmt -> Cmp ()
stmt s = case s of
	(Assign pos name ex) -> do
		fn <- getCurFn
		case SymTab.lookup name [(head $ symTab fn)] of
			Just _  -> error $ name ++ " already defined"
			Nothing -> return ()

		val <- expr ex
		let typ = typeOf val

		allocRef <- unique
		let allocLocal = local typ allocRef
		let alloc = LL.Alloca typ Nothing 0 []

		instr $ allocRef LL.:= alloc 
		instr $ LL.Do $ LL.Store False allocLocal val Nothing 0 []

		let (name', names') = uniqueName name (names fn)
		modifyCurFn $ \f -> f { symTab = SymTab.insert name allocLocal (symTab f), names = names' }
		return ()

	(Print pos [e]) -> do
		val <- expr e
		case typeOf val of
			LL.IntegerType nb -> printf "%d\n" [val]

		return ()

			
expr :: Expr -> Cmp LL.Operand
expr e = case e of
	S.Int pos n -> return $ cons (LLC.Int 32 $ toInteger n)

	S.Ident pos name -> do
		fn <- getCurFn
		op <- case SymTab.lookup name (symTab fn) of
			Just x  -> return x
			Nothing -> error $ name ++ " doesn't exist"

		ref <- unique
		instr $ ref LL.:= LL.Load False op Nothing 0 []
		return $ local (typeOf op) ref


str :: String -> Cmp LL.Operand
str s = do
	let chars     = map (LLC.Int 8 . toInteger . ord) (s ++ "\0")
	let strArr    = LLC.Array LL.i8 chars
	let strArrTyp = typeOf (cons strArr)

	consName <- addConstant "str" strArr
	let consRef = global (LL.ptr strArrTyp) consName
	return $ cons $ LLC.BitCast (LLC.GetElementPtr False consRef []) (LL.ptr LL.i8)


puts :: String -> Cmp LL.Operand
puts s = do
	let putsTyp = LL.FunctionType LL.i32 [LL.ptr LL.i8] False
	let puts    = cons $ global (LL.ptr putsTyp) (LL.mkName "puts")

	arg <- str s
	ref <- unique
	instr $ ref LL.:= LL.Call Nothing LL.C [] (Right puts) [(arg, [])] [] []
	return (local LL.i32 ref)


printf :: String -> [LL.Operand] -> Cmp LL.Operand
printf fmt args = do
	let printfTyp = LL.FunctionType LL.i32 [LL.ptr LL.i8] True
	let printf    = cons $ global (LL.ptr printfTyp) (LL.mkName "printf")

	fmtArg <- str fmt
	ref <- unique
	let printfArgs = map (\arg -> (arg, [])) (fmtArg : args)
	instr $ ref LL.:= LL.Call Nothing LL.C [] (Right printf) printfArgs [] []
	return (local LL.i32 ref)
