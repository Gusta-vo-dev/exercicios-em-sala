Program lista_encadeada;

 uses crt;
 
 type
 		ponteiro = ^elemento;
 		elemento = record
 			dado: integer;
 			prox: ponteiro;
 		end;
 		
 var lista: ponteiro;
 		 num: integer;
 		 op: byte;
 		 
 procedure criarLista (var list: ponteiro );
 begin
 		list:= nil;
 end; 

 procedure inserirInicio ( var list: ponteiro; n: integer );
 var aux: ponteiro;
 begin
 		new(aux);
 		writeln;
 		write ('   Digite o número que você deseja inserir no inicio da lista: ');
 		readln ( n );
 	  	aux^.dado:= n;
 		aux^.prox:= list;
 		list:= aux;
 end;

 procedure inserirFim ( var list: ponteiro; n: integer);
 var aux, novo: ponteiro;
 begin
 		new(novo);
 		writeln;
 		write ('   Digite o número que você deseja inserir no fim da lista: ');
 		readln ( n );
 		novo^.dado:= n;
 		novo^.prox:= nil;
 		if list = nil then
 	     list:= novo
 		else
 		begin
 		  aux:= list;
			while aux^.prox <> nil do
				 aux:= aux^.prox;
			aux^.prox:= novo;
 		end;
 end;
 
 procedure lerLista ( list: ponteiro );
 var aux: ponteiro;
 begin
    aux:= list; 
    if aux = nil then
    		writeln ('   A sua memória está vazia!')
    else
    begin
    	writeln;
    	write ('   ');
	 	  while aux <> nil do
	 	  begin
					write ('[', aux^.dado, '] -> ');	
					aux:= aux^.prox;
			end;
			writeln (' NIL');
			writeln;
		end;
 end;
 
 procedure inserirMeio ( var list: ponteiro; n: integer);
 var aux, novo, anterior: ponteiro;
 		 dado: integer;
 begin
 		if list = nil then
 		begin
 			new(aux);
 			writeln;
			write ('   Digite o número que você deseja inserir no meio da lista: ');
			readln ( n );
 			aux^.dado:= n;
 			aux^.prox:= nil;
 			list:= aux;
 		end
 		else
 		begin
 			new(novo);
 			aux:= list;
 			anterior:= nil;
			writeln;
			lerLista ( list );
			writeln;
			write ('   Digite o dado(número) sucessor da posição que voce deseja inserir: ');
			readln ( dado );
			writeln;
			while aux^.dado <> dado do
			begin
			  anterior:= aux;
				aux:= aux^.prox;
			end;
			if aux = nil then
      begin
          writeln('   Valor de referência não foi encontrado em sua lista!');
      end
      else
      begin
        writeln;
				write ('   Digite o número que você deseja inserir no meio da lista: ');
				readln ( n );
				novo^.dado:= n;
        if anterior = nil then
        begin
        	 novo^.prox:= list;
        	 list:= novo;
        end
        else
        begin
        	 novo^.prox:= aux;
        	 anterior^.prox:= novo;
        end;
		  end;
		end;
 end;
 
 procedure remover ( var list: ponteiro );
 var aux, anterior: ponteiro;
 		 dado: integer; 
 		 cont: boolean;
 begin
 		writeln;
 	  if list = nil then
 	  	writeln ('   A sua memória está vazia!')
		else  
		begin
		    lerLista ( list );
				write ('   Digite o dado que você deseja remover da sua lista: ');
				readln ( dado );
				aux:= list;
				cont:= false;
				while aux^.dado <> dado do
				begin
				  cont:= true;
					anterior:= aux;
					aux:= aux^.prox;
				end;
				if aux = nil then
					writeln ('   Valor de referência não foi encontrado em sua lista!')
				else  
				begin
				  if cont = true then
				  begin
				  	aux:= aux^.prox;
				  	anterior^.prox:= aux;
				  end
				  else
				  begin
				  	aux:= aux^.prox;
						list:= aux;	
				  end;
				end;
		end;
 end;
	 
 //---------------------------------------------------------------------//
	 
Begin
  	criarLista ( lista );
		num:= 0;
	  while true do
		begin	
	  		writeln ('   --------------------------------------------');
	  		writeln ('   0 - Encerrar Programa');
	  		writeln ('   1 - Inserir no Inicio');
	  		writeln ('   2 - Inserir no Fim');
	  		writeln ('   3 - Inserir no Meio');
	  		writeln ('   4 - Remover da Lista');
	  		writeln ('   5 - Consultar Lista');                  
	  		writeln ('   --------------------------------------------');
	  	repeat
	  		write ('   Escolha uma opção para sua Lista Encadeada: ');
	  		readln ( op );
	  		writeln;
	  		case op of
	  			0: halt;
	  			1: inserirInicio ( lista, num );
	  			2: inserirFim ( lista, num );
	  			3: inserirMeio( lista, num );
	  			4: remover ( lista );
	  			5: lerLista ( lista );	  			
	  		end;
	  	until ( op in [0..5]);
	  readkey;
	  ClrScr;
	  end;
End.