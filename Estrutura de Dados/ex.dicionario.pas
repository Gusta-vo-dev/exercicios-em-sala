Program dicionario; 

	type 
		ponteiro = ^chave;
		chave = record
			dado: string;
			prox: ponteiro;
			ant: ponteiro;
	  end;
	  
	  ptno = ^segundaria;
	  segundaria = record
	  	dado: string;
	  	trad: string;
	  	prox: ptno;
	  end;
	  
	var lista_chave: ponteiro;
			lista_segundaria: ptno;
			palavra: string[20];
			op: byte;
	
	procedure criar_dicionario( var list_c: ponteiro; var list_s: ptno);
	begin
		 list_c:= nil;
		 list_s:= nil;
	end;
	
	procedure leitura ( var pal: string );
	begin
			writeln;
			write (' Digite a palavra que você deseja inserir: ');
			readln ( pal );
			pal:= upcase(pal);
	end;
	
	procedure inserir_chave ( var list_c: ponteiro );
	var aux, aux2, anterior: ponteiro;
			i, tam: integer;
			p: string;
			cont: boolean;
	begin
	   repeat
			 write (' Digite a quantidade de palavras que você deseja ter em seu dicionário( MÁX = 5 ): ');
			 readln ( tam );
		 until ( tam in [1..5] );
		 for i:=1 to tam do 
		 begin
		 		leitura ( p );
		 		new(aux);
		 		aux2:= list_c;
		 		if (list_c = nil) or ( p < aux2^.dado ) then
		 		begin
		 		   aux^.dado:= p;
		 			 aux^.prox:= list_c;
		 			 list_c:= aux;
		 		end
		 		else
		 		begin 
		 		   while (aux2^.dado < p) and (aux2 <> nil) do
		 		   begin
		 		   		anterior:= aux2;
		 		   		aux2:= aux2^.prox;
		 		   end;
		 		   aux^.dado:= p;
		 		   aux^.prox:= aux2;
		 		   anterior^.prox:= aux;
		 		end;
		 end;
	end;
	
  procedure inserirDic( list_s: ptno);
  var aux, aux2: ptno;
  begin
  		
  end;
	  	

	procedure consulta ( list_c: ponteiro);
	var aux: ponteiro;
	begin
			aux:= list_c;
			write(' ');
			while aux <> nil do
			begin
				 write ( aux^.dado ,' -> ');
				 aux:= aux^.prox;
			end;
			write('FIM');
			writeln;
	end; 

Begin
  criar_dicionario ( lista_chave, lista_segundaria );
  inserir_chave ( lista_chave );
  while true do
  begin
  	writeln;
  	writeln (' 0 - Fechar Dicionário');
  	writeln (' 1 - Inserir Palavras no Dicionário');
  	writeln (' 2 - Remover Palavras do Dicionário');
  	writeln (' 3 - Consultar Dicionário');
  	writeln (' 4 - Escrever o Dicionário');
  	writeln;
  	repeat
  		write (' Escolha uma opção para sua lista: ');
  	  readln ( op );
  	until ( op in [0..3] );
  	writeln;
    case op of
      0: halt;
      1: inserir;
      2: writeln;
      3: consulta( lista_chave );
    end;
    readkey;
    clrscr;
  end;
  readkey;
End.