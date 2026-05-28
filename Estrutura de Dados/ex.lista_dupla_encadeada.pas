Program lista_dupla_encadeada;

 type 
    ponteiro = ^elemento;
    elemento = record
    	dado: string;
    	prox: ponteiro;
    	ant: ponteiro;
    end;
 
 var lista, tail: ponteiro;
     palavra: string;
     op: byte;
 
 procedure criarLista (var list, calda: ponteiro);
 begin
 		list:= nil;
 		calda:= nil;
 end;
 
 procedure consultar ( list: ponteiro );
 var aux: ponteiro;
 begin
 		writeln;
 		if list = nil then
 				writeln ('A memória da sua lista está cheia!')
 		else 
 		begin
 		   aux:= list;
 		   write('LISTA <-> ');
 			 while aux <> nil do
 			 begin
 			 		write ('[',aux^.dado,'] <-> ');
					aux:= aux^.prox;
			 end;
			 write ('CALDA');
			 writeln;
 		end;
 end; 
 
 procedure inserirInicio ( var list, calda: ponteiro; pal: string );
 var aux, aux2: ponteiro;
 begin
    new( aux );
    write('Digite a palavra que você deseja inserir no inicio da sua lista: ');
    readln ( pal );
 		if list = nil then
 		begin
 			 aux^.dado:= pal;
 			 aux^.prox:= nil;
 			 aux^.ant:= nil;
 			 list:= aux;
 			 calda:= aux;
 		end
 		else
 		begin
 			aux2:= list;
			aux^.dado:= pal;
			aux^.prox:= aux2;
			aux^.ant:= aux;
			aux^.ant:= nil;
			list:= aux; 
 		end;
 end;
 
 procedure inserirFim ( var list, calda: ponteiro; pal: string );
 var aux, aux2: ponteiro;
 begin
 		new(aux);
 		write('Digite a palavra que você deseja inserir no fim da sua lista: ');
    readln ( pal );
 		if list = nil then
 		begin
 			aux^.dado:= pal;
 			aux^.prox:= nil;
 			aux^.ant:= nil;
 			list:= aux;
 			calda:= aux;
 		end
 		else
 		begin
 		  aux2:= calda;
 			aux^.dado:= pal;
 			aux^.prox:= nil;
 			aux^.ant:= calda;
 			calda:= aux;
 			aux2^.prox:= aux;
 		end;
 end;
 
 
 //ERRO AO INSERIR NO MEIO - AJUSTAR//
 
 procedure inserirMeio ( var list, calda: ponteiro; pal: string );
 var aux, aux2, anterior: ponteiro;
 		 ref: string;
 		 cont: boolean;
 begin
 	  new(aux);
 	  write('Digite a palavra que você deseja inserir no meio da sua lista: ');
    readln ( pal );
 	  aux2:= list;
 	  cont:= false;
 	  while ref <> aux2^.dado do
 	  begin
 	  	cont:= true;
 	  	anterior:= aux2; 
 	  	aux2:= aux2^.prox;
		end;	
		if cont = false then
		begin
			aux^.dado:= pal;
 			aux^.prox:= nil;
 			aux^.ant:= nil;
 			list:= aux;
 			calda:= aux;
		end
		else
		begin
		   consultar ( list );
	 	   write ('Escreva a palavra sucessora da posição que você deseja inserir: ');
	 	   readln ( ref );
			 aux^.dado:= pal;
			 aux^.prox:= aux2;
			 aux^.ant:= anterior;
			 anterior^.prox:= aux;
		end;
 end;


Begin
    criarLista ( lista, tail );
	  while true do
		begin	
	  		writeln ('   --------------------------------------------');
	  		writeln ('   0 - Encerrar Programa');
	  		writeln ('   1 - Inserir no Inicio');
	  		writeln ('   2 - Inserir no Fim');
	  		writeln ('   3 - Inserir no Meio');
	  		//writeln ('   4 - Remover da Lista');
	  		writeln ('   5 - Consultar Lista');
				writeln ('   6 - Esvaziar Memória');                  
	  		writeln ('   --------------------------------------------');
	  	repeat
	  		write ('   Escolha uma opção para sua Lista Encadeada: ');
	  		readln ( op );
	  		writeln;
	  		case op of
	  			0: halt;
	  			1: inserirInicio ( lista, tail, palavra );
	  			2: inserirFim ( lista, tail, palavra );
	  			3: inserirMeio ( lista, tail, palavra );
					5: consultar ( lista );
					6: criarLista ( lista, tail );	  			
	  		end;
	  	until ( op in [0..6]);
	  readkey;
	  ClrScr;
	  end;
End.