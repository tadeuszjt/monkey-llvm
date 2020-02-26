{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Compiler where

import qualified Data.Map as Map
import Control.Monad.State
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Short as BSS

import qualified LLVM.AST as LL
import qualified LLVM.AST.Type as LL
import qualified LLVM.AST.Global as LL
import qualified LLVM.AST.Name as LL
import qualified LLVM.AST.Instruction as LL
import qualified LLVM.AST.Operand as LLOp
import qualified LLVM.AST.Constant as LL

import Lexer as L
import AST as S
import qualified SymTab 


compileAST :: AST -> LL.Module
compileAST ast =
	let state = execState (getCmp $ cmpAST ast) initCmpState
	in llModule state


makeBlock :: [LL.Named LL.Instruction] -> LL.Named LL.Terminator -> LL.BasicBlock
makeBlock = LL.BasicBlock (LL.UnName 1) 


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
initFnState = FnState 0 SymTab.initSymTab "entry" (Map.singleton "entry" initBlockState)
initCmpState = CmpState LL.defaultModule Map.empty ""


cmpAST :: AST -> Cmp ()
cmpAST = mapM_ stmt 


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


lookupName :: Name -> Cmp (Maybe LL.Operand)
lookupName name = fmap (SymTab.lookup name) (fmap symTab getCurFn)


stmt :: Stmt -> Cmp ()
stmt (Assign _ name e) = do
	l <- lookupName name
	case l of
		Just n  -> error $ name ++ " already defined"
		Nothing -> return ()

	val <- expr e
	ptr <- instr $ LL.Alloca LL.i32 Nothing 0 []
	instr $ LL.Store False ptr val Nothing 0 []
	return ()


expr :: Expr -> Cmp LL.Operand
expr (S.Int pos n) =
	return $ LL.ConstantOperand (LL.Int 32 $ toInteger n)
