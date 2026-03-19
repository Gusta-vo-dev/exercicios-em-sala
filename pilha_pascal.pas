Program ex_pilha ;
	const max = 3;            
	type vetor = array[1..max] of integer;
	
	var pilha:vetor;
	    posi:integer;  
			op:byte;
	
	Function cheio(posisao:integer): boolean ;
	Begin
	 if (posisao = max) then
	  cheio:=true  
	End;
	
	Function vazio (posisao:integer) : boolean ;
	Begin
	  if (posisao = 0) then
	   vazio:=true;
	End;
	
	procedure consultar (pil:vetor;posisao:integer);
	Begin
	  writeln('proximo numero: ',pil[posisao]);
	  writeln;
	End;
	
	procedure incluir(var pil:vetor;var posisao:integer);
	begin
	 if (cheio(posisao)) then
	  writeln('a pilha esta cheia!!!')
	 else
	 begin
	write('digite o valor: ') ;
	posisao:= posisao +1;
	read (pil[posisao]);
	
	 end;
	 writeln;
	end;
	
	procedure remover (var posisao:integer);
	begin
	  if (vazio(posisao)) then
	   writeln('pilha vazia')
	  else
	 posisao:= posisao - 1;
	end;
	
	Procedure escrever(pil:vetor;posisao:integer);
	var i :integer ;
	Begin
	writeln;
	writeln(' Assim está a pilha: ');
	writeln('---------------------');
	  for i:= 1 to posisao do
	      write(pil[i],' | ' ) ;
	  writeln;    
	  writeln('---------------------');
	End;
	
	
	
Begin
	 repeat
	  writeln('=====MENU=====');
	  writeln(' 1 - INSERIR');
	  writeln(' 2 - REMOVER');
	  writeln(' 3 - CONSULTAR');
	  writeln(' 4 - ESCREVER');
	  writeln(' 0 - SAIR');
	  writeln('==============' ) ;
	  read(op);
	  if (op in [1,2,3,4,0]) then
	  begin
			 case(op) of
			  1:incluir(pilha,posi);
			  2:remover(posi);
			  3:consultar(pilha,posi);
			  4:escrever(pilha,posi);
			  0: write('ENCERRANDO O PROGRAMA...')
			 end;
	  end
	  else
	  begin
		   writeln('Número inválido! Insira novamente: ');
			 writeln;
		end;
	 until ( op = 0 );
End.