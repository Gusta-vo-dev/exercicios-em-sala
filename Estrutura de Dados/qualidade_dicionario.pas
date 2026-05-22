Program qualidade_dicionario; 

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
	  
	var lista_chave, tail: ponteiro;
			lista_segundaria: ptno;
			palavra: string[20];
			op: byte;
	
	procedure criar_dicionario( var list_c: ponteiro; var calda: ponteiro; var list_s: ptno);
	begin
		 list_c:= nil;
		 calda:= nil;
		 list_s:= nil;
	end;
	
	procedure leitura ( var pal: string );
	begin
			writeln;
			write (' Digite a palavra que você deseja inserir: ');
			readln ( pal );
			pal:= upcase(pal);
	end;
	
	procedure inserirChave ( var list_c: ponteiro; var calda: ponteiro);
	var aux, aux2, aux3: ponteiro;
			i, tam: integer;
			p: string;
			cont: boolean;
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
		 		   		antes:= aux2;
		 		   		aux2:= aux2^.prox;
		 		   end;
		 		   aux^.dado:= p;
		 		   aux^.prox:= aux2;
		 		   antes^.prox:= aux;
		 		end;
	end;
	
  procedure inserirDic( var list_c: ponteiro; var list_s: ptno );
  var aux, aux2: ptno;
  begin
  		
  end;
	  	

	procedure escreverDic ( list_c: ponteiro);
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
  criar_dicionario ( lista_chave, tail, lista_segundaria );
  while true do
  begin
  	writeln;
  	writeln (' 0 - Fechar Dicionário');
  	writeln (' 1 - Inserir Palavra-Chave');
  	writeln (' 2 - Inserir Palavras no Dicionário');
  	writeln (' 3 - Remover Palavras do Dicionário');
  	writeln (' 4 - Consultar Dicionário');
  	writeln (' 5 - Escrever o Dicionário');
  	writeln;
  	repeat
  		write (' Escolha uma opção para sua lista: ');
  	  readln ( op );
  	until ( op in [0..5] );
  	writeln;
    case op of
      0: halt;
      1: inserirChave ( lista_chave, tail );
      2: inserirDic ( lista_chave, lista_segundaria );
      3: writeln;
      4: writeln;
      5: escreverDic( lista_chave );
    end;
    readkey;
    clrscr;
  end;
  readkey;
End.