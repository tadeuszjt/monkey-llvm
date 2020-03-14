main: Parser.hs Lexer.hs AST.hs Compiler.hs LLVMWrap.hs Main.hs SymTab.hs test.monkey
	ghc *.hs -outputdir build

Parser.hs: Parser.y
	happy Parser.y

Pexer.hs: Lexer.x
	alex Lexer.x

run: main test.monkey
	rm -f main.ll main.s
	./Main test.monkey > main.ll	
	llc main.ll
	gcc -no-pie main.s
	./a.out || true
