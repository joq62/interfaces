all:
#	
	rm -rf ebin *.dump *.beam *~
doc_gen:
	rm -rf ebin *.dump *.beam *~
	mkdir ebin;
	erlc -o ebin doc_gen.erl;
	erl -pa ebin -s doc_gen start
