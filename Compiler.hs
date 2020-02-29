{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler where


import Data.Function
import Data.List
import qualified Data.Map as Map
import Control.Monad.State
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Short as BSS

import qualified LLVM.AST as LL
import qualified LLVM.AST.Type as LL
import qualified LLVM.AST.Global as LL
import qualified LLVM.AST.Name as LL
import qualified LLVM.AST.Instruction as LL
import qualified LLVM.AST.Constant as LL

import Lexer as L
import AST as S
import qualified SymTab 


compileAST :: AST -> LL.Module
compileAST ast =
	let state = execState (getCmp $ cmpAST ast) initCmpState
	in llModule state


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
		{ unCount  :: Word
		, symTab   :: SymTab.SymTab Name LL.Operand
		, curBlock :: Name
		, blocks   :: Map.Map Name BlockState
		, names    :: Names
		}
	deriving (Show)


-- Cmp state
data CmpState
	= CmpState
		{ llModule  :: LL.Module
		, functions :: Map.Map Name FnState
		, currentFn :: Name
		}
	deriving (Show)


newtype Cmp a
	= Cmp { getCmp :: State CmpState a }
	deriving (Functor, Applicative, Monad, MonadState CmpState)


initBlockState = BlockState 0 [] Nothing
initFnState = FnState 0 SymTab.initSymTab "entry" (Map.singleton "entry" initBlockState) Map.empty
initCmpState = CmpState LL.defaultModule (Map.singleton "main" initFnState) "main"


cmpAST :: AST -> Cmp ()
cmpAST ast = do
	mapM_ stmt ast
	fn <- getCurFn
	let blks = blocks fn
	let sortedBlocks = sortBy (compare `on` (idx . snd)) (Map.toList blks)
	ref <- unique
	terminator $ (ref LL.:= LL.Ret Nothing [])

	defFunc LL.void "main" [] (map makeBlock sortedBlocks)
	where
		makeBlock :: (Name, BlockState) -> LL.BasicBlock
		makeBlock (name, blk) = LL.BasicBlock (LL.mkName name) (reverse $ stack blk) (LL.Do $ LL.Ret Nothing [])


addDef :: LL.Definition -> Cmp ()
addDef def = do
	llMod <- gets llModule
	let defs = LL.moduleDefinitions llMod
	modify $ \s -> s { llModule = llMod { LL.moduleDefinitions = defs ++ [def] } }


defFunc :: LL.Type -> String -> [(LL.Type, LL.Name)] -> [LL.BasicBlock] -> Cmp ()
defFunc retType label argTypes body = addDef $ 
	LL.GlobalDefinition $ LL.functionDefaults
		{ LL.name        = LL.mkName label
		, LL.parameters  = (map (\(ty, nm) -> LL.Parameter ty nm [])  argTypes, False)
		, LL.returnType  = retType
		, LL.basicBlocks = body
		}


getCurFn :: Cmp FnState
getCurFn = do
	name <- gets currentFn
	fns <- gets functions
	return $ (Map.!) fns name


putCurFn :: FnState -> Cmp ()
putCurFn f = do
	name <- gets currentFn 
	modify $ \s -> s { functions = Map.insert name f (functions s) }


getCurBlock :: Cmp BlockState
getCurBlock = do
	fn <- getCurFn
	return $ (Map.!) (blocks fn) (curBlock fn)


putCurBlock :: BlockState -> Cmp ()
putCurBlock block = do
	fn <- getCurFn
	putCurFn $ fn { blocks = Map.insert (curBlock fn) block (blocks fn) }


pushScope :: Cmp ()
pushScope = do
	fn <- getCurFn
	putCurFn $ fn { symTab = SymTab.push (symTab fn) }


popScope :: Cmp ()
popScope = do
	fn <- getCurFn
	putCurFn $ fn { symTab = SymTab.pop (symTab fn) }


unique :: Cmp LL.Name
unique = do
	fn <- getCurFn 
	let count = unCount fn
	putCurFn $ fn { unCount = count + 1 }
	return $ LL.UnName count


instr :: LL.Instruction -> Cmp LL.Operand
instr ins = do
	ref <- unique
	blk <- getCurBlock
	putCurBlock $ blk { stack = (ref LL.:= ins) : (stack blk) }
	return $ LL.LocalReference LL.i32 ref


refInstr :: LL.Name -> LL.Instruction -> Cmp ()
refInstr ref ins = do
	blk <- getCurBlock
	putCurBlock $ blk { stack = (ref LL.:= ins) : (stack blk) }


doInstr :: LL.Instruction -> Cmp ()
doInstr ins = do
	blk <- getCurBlock
	putCurBlock $ blk { stack = (LL.Do ins) : (stack blk) }


terminator :: LL.Named LL.Terminator -> Cmp ()
terminator term = do
	blk <- getCurBlock
	putCurBlock $ blk { term = Just term }


lookupName :: Name -> Cmp (Maybe LL.Operand)
lookupName name = fmap (SymTab.lookup name) (fmap symTab getCurFn)


stmt :: Stmt -> Cmp ()
stmt (Assign _ name e) = do
	fn <- getCurFn
	case SymTab.lookup name [head $ symTab fn] of
		Just n  -> error $ name ++ " already defined"
		Nothing -> return ()

	let (unName, names') = uniqueName name (names fn)
	let ref = LL.mkName unName
	let loc = local i32 ref

	putCurFn $ fn
		{ symTab = SymTab.insert name loc (symTab fn)
		, names  = names'
		}

	alloca ref i32
	store loc =<< expr e
		
stmt (Block stmts) =
	pushScope >> mapM_ stmt stmts >> pushScope


expr :: Expr -> Cmp LL.Operand
expr (S.Int pos n) =
	return $ LL.ConstantOperand (LL.Int 32 $ toInteger n)

expr (S.Ident pos name) = do
	l <- lookupName name
	case l of
		Just op -> return op
		Nothing -> error $ name ++ " does not exist"


-- LL Instruction wrappers
i32 :: LL.Type
i32 = LL.i32


local :: LL.Type -> LL.Name -> LL.Operand
local typ ref = LL.LocalReference typ ref


alloca :: LL.Name -> LL.Type -> Cmp ()
alloca ref typ = refInstr ref $ LL.Alloca typ Nothing 0 []


store :: LL.Operand -> LL.Operand -> Cmp ()
store ptr val = doInstr $ LL.Store False ptr val Nothing 0 []
