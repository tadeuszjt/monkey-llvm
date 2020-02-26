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


-- Cmp state
data FnState
	= FnState
		{ unCount :: Word
		, symTab  :: SymTab.SymTab Name LL.Operand
		}
	deriving (Show)


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


initFnState = FnState 0 SymTab.initSymTab [] Nothing
initCmpState = CmpState LL.defaultModule (Map.singleton "main" initFnState)


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


unique :: Cmp LL.Name
unique = do
	fnState:fs <- gets functions
	let count = unCount fnState

	modify $ \s -> s { functions = (fnState { unCount = count + 1 }):fs }
	return $ LL.UnName count


emit :: LL.Named LL.Instruction -> Cmp ()
emit ins = do
	fnState:fs <- gets functions
	let fnState' = fnState { stack = (stack fnState) ++ [ins] }
	modify $ \s -> s { functions = fnState':fs }


lookup :: Name -> Cmp LL.Operand
lookup name = do
	fnState:fs <- gets functions
	case SymTab.lookup name (symTab fnState) of
		Just x  -> return x
		Nothing -> error $ name ++ " not found"


assign :: Name -> LL.Operand -> Cmp ()
assign name typ op = do
	fnState:fs <- gets functions
	case SymTab.lookup name (symTab fnState) of
		Just _  -> error $ name ++ " already defined" 
		Nothing -> return ()

	let fnState' = fnState { symTab = SymTab.insert name op (symTab fnState) }
	modify $ \s -> s { functions = fnState':fs } 


pushScope :: Cmp ()
pushScope = do
	fnState:fs <- gets functions
	let fnState' = fnState { symTab = SymTab.push (symTab fnState) }
	modify $ \s -> s { functions = fnState':fs }

		
popScope :: Cmp ()
popScope = do
	fnState:fs <- gets functions
	let fnState' = fnState { symTab = SymTab.pop (symTab fnState) }
	modify $ \s -> s { functions = fnState':fs }

