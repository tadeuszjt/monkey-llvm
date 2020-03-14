module LLVMWrap where

import qualified Data.Map as Map
import Data.List
import Data.Function

import LLVM.AST
import LLVM.AST.Type
import LLVM.AST.Global
import LLVM.AST.Name
import LLVM.AST.Instruction
import LLVM.AST.Constant
import LLVM.AST.Linkage
import LLVM.AST.AddrSpace
import LLVM.AST.AddrSpace
import LLVM.AST.CallingConvention

import Compiler


cmpToModule :: CmpState -> Module
cmpToModule s =
	defaultModule
		{ moduleDefinitions = [putsDef] ++ [printfDef] ++ concat funcDefs
		}
	where
		putsDef = extFunc i32 "puts" [(ptr i8, mkName "s")] False
		printfDef = extFunc i32 "printf" [(ptr i8, mkName "fmt")] True

		funcDefs = map defFunc $ Map.toList (funcs s)

		defCons :: (Name, Constant) -> Definition
		defCons (name, cons) =
			GlobalDefinition $ globalVariableDefaults
				{ name                  = name
				, LLVM.AST.Global.type' = typeOf (ConstantOperand cons)
				, initializer           = Just cons
				}
		
		defFunc :: (Name, FnState) -> [Definition]
		defFunc (name, fnState) = map defCons (Map.toList $ constants fnState) ++ [fnDef] 
			where
				fnDef = GlobalDefinition $ functionDefaults
					{ name        = name
	--				, parameters  = (map (\(ty, nm) -> Parameter ty nm [])  argTypes, False)
					, returnType  = void 
					, basicBlocks = map makeBlock $ sortBlocks $ Map.toList (blocks fnState)
					}



		sortBlocks :: [(Name, BlockState)] -> [(Name, BlockState)]
		sortBlocks = sortBy (compare `on` (idx . snd))

		makeBlock :: (Name, BlockState) -> BasicBlock
		makeBlock (l, (BlockState _ s t)) = BasicBlock l (reverse s) (makeTerm t)
			where
				makeTerm (Just x) = x
				makeTerm Nothing  = error $ "Block has no terminator: " ++ (show l)


		extFunc :: Type -> String -> [(Type, Name)] -> Bool -> Definition
		extFunc retType name argTypes isVarg =
			GlobalDefinition $ functionDefaults
				{ name = mkName name
				, parameters = ([Parameter ty nm [] | (ty, nm) <- argTypes], isVarg)
				, returnType = retType
				}

