Program lista_encadeada;

 type
 		ponteiro = ^elemento;
 		elemento = record
 			dado: integer;
 			prox: ponteiro;
 		end;
 		
 var lista: ponteiro;
 		 num: integer;
 		 op: byte;
 		 
 procedure criarLista ( list: ponteiro );
 begin
 		list:= nil;
 end; 

 procedure inserirInicio ( var list: ponteiro; n: integer );
 var aux, aux2: ponteiro;
 begin
 		new(aux);
 		writeln;
 		write ('	Digite o número que você deseja inserir no ínicio da lista: ');
 		readln ( n );
 	  aux^.dado:= n;
 		aux^.prox:= list;
 		list:= aux;
 end;

 procedure lerLista ( list: ponteiro );
 var i: integer;
		 aux: ponteiro;
 begin
    aux:= list; 
    if aux = nil then
    		writeln ('	A sua lista está vazia!')
    else
    begin
    	writeln;
    	write ('	');
	 	  while aux <> nil do
	 	  begin
					write ('[', aux^.dado, '] -> ');	
					aux:= aux^.prox;
			end;
			writeln (' NIL');
		end;
 end;

 procedure inserirFim ( var list: ponteiro; n: integer);
 var aux, aux2: ponteiro;
 begin
 		new(aux);
 		writeln;
 		write ('	Digite o número que você deseja inserir no fim da lista: ');
 		readln ( n );
 		if list = nil then
 		begin
 			 aux^.dado:= n;
 			 aux^.prox:= list;
 	     list:= aux;
 		end
 		else
 		begin
 		  new(aux2);
			while aux^.prox <> nil do
				 aux:= aux^.prox;
			aux^.prox:= aux2;
			aux2^.dado:= n;
			aux2^.prox:= nil;
 		end;
 end;

Begin
  	criarLista ( lista );
	  while true do
		begin	
	  		writeln ('	--------------------------------------------');
	  		writeln ('	0 - Encerrar Programa');
	  		writeln ('	1 - Inserir no Ínicio');
	  		writeln ('	2 - Inserir no Fim');
	  		writeln ('	3 - Consultar a Lista');
	  		writeln ('	--------------------------------------------');
	  	repeat
	  		write ('	Escolha uma opção para sua Lista Encadeada: ');
	  		readln ( op );
	  		writeln;
	  		case op of
	  			0: halt;
	  			1: inserirInicio ( lista, num );
	  			2: inserirFim ( lista, num );
	  			3: lerLista ( lista );
	  		end;
	  	until ( op in [0..3]);
	  end;
End.