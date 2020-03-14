import System.IO
import System.Environment

import qualified Data.ByteString.Char8 as BS

import qualified Lexer as L
import qualified Parser as P
import qualified AST as S
import qualified Compiler as C
import LLVMWrap

import LLVM.AST as VS
import LLVM.Module as V
import LLVM.Context as V


putLLVMModule :: VS.Module -> IO ()
putLLVMModule mod =
	V.withContext $ \ctx -> do
		llvm <- V.withModuleFromAST ctx mod V.moduleLLVMAssembly
		BS.putStrLn llvm


main :: IO ()
main = do
	[fileName] <- getArgs
	handle <- openFile fileName ReadMode
	content <- hGetContents handle

	let tokens = L.alexScanTokens content
	let ast = P.parseTokens tokens
	let mod = cmpToModule (C.compileAST ast)
	putLLVMModule mod

	hClose handle
	
--	where
--		printError (L.AlexPn offset l c, str) contents fname = do
--			let lines' = lines [if c == '\t' then ' ' else c | c <- contents ]
--			let line = lines' !! (l-1)
--			mapM_ (hPutStrLn stderr) [
--				"",
--				concat [fname, ":", show l, ":", show c, ": ", str],
--				if l>=2 then lines' !! (l-2) else "",
--				line,
--				replicate (c-1) '-' ++ "^",
--				""
--				]
