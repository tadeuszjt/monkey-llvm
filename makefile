main: Parser.hs Lexer.hs AST.hs Compiler.hs Main.hs SymTab.hs test.monkey
	ghc *.hs -outputdir build

Parser.hs: Parser.y
	happy Parser.y

Pexer.hs: Lexer.x
	alex Lexer.x
