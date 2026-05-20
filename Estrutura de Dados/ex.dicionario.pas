Program dicionario; 

	type 
		ponteiro = ^chave;
		chave = record
			dado: string;
			prox: ponteiro;
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
			write ('Digite a palavra que você deseja inserir: ');
			readln ( pal );
	end;
	
	procedure inserir_chave ( var list_c: ponteiro );
	var aux, aux2, anterior: ponteiro;
			i, tam: integer;
			p: string;
			cont: boolean;
	begin
		 write ('Digite a quantidade de palavras que você deseja ter em seu dicionário( MÁX = 5 ): ');
		 readln ( tam );
		 for i:=1 to tam do 
		 begin
		 		leitura ( p );
		 		new(aux);
		 		if list_c = nil then
		 		begin
		 			aux^.dado:= p;
		 			aux^.prox:= nil;
		 			list_c:= aux;
		 		end
		 		else
		 		begin 
		 		   cont:= false;
		 		   aux2:= list_c;
		 		   while aux2^.dado > p do
		 		   begin
		 		      cont:= true;
		 		   		anterior:= aux2;
		 		   		aux2:= aux2^.prox;
		 		   end;
		 		   aux^.dado:= p;
		 		   aux^.prox:= aux2;
		 		   if cont = true then
		 		   		list_c:= aux
		 		   else
		 		   		anterior^.prox:= aux;
		 		end;
		 end;
	end;
	
  procedure inserir ( list_s: ptno);
  var aux: ptno;
  begin
  		aux:= nil;
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
			write('NIL');
			writeln;
	end; 

Begin
  criar_dicionario ( lista_chave, lista_segundaria );
  inserir_chave ( lista_chave );
  consulta ( lista_chave );
  readkey;
End.