Program ex_lista ;
		
		type
			lista = array [1..10] of integer;
			
		var total, i, tamanho:integer;
				list: lista;
				op: byte;

		procedure inserir(var l: lista);
		var valor: integer;
		begin 
				if total = 10 then
						writeln (' A sua lista está cheia! Remova números para poder inserir novos!')
				else
				begin
						writeln;
						write ('Digite o número que você quer inserir: ');
						readln( valor );
						writeln;
					 if total < 10 then
					 begin
							 	for i:= total downto 1 do
								  	l[i + 1]:= l[i];
								l[1]:= valor;
								total:= total + 1;
					 end;	
				end;
		end;
		
		procedure consultar ( l: lista);
		begin
				write ( '   ');
				for i:=1 to total do 
						write ( l[i], ' | ');
				writeln;
				writeln;
		end;
		
		procedure remover (var l: lista);
		var r: integer;
				verifica: boolean;
		begin
			if total = 0  then	
					writeln (' A sua lista está vazia! Insira números nela para poder remove-los!')
			else
			begin
					for i:=1 to total do
					  		write(' ', i, ' | ');
					write (' < POSIÇÕES ');
					writeln;
					writeln(' -----------------');
					for i:=1 to total do
					  		write(' ', list[i], ' | ');
					write (' < NÚMEROS DA LISTA');
					writeln;
					repeat
					  writeln;
					  writeln('------------------------------------------------------');
					  write('Escolha a posição que você quer retirar de sua lista: ');
					  readln ( r );
					  writeln;
					  if ( r <= total) then
					  begin
					  	verifica:= true;
						  for i:= r to total do
						  	list[i]:= list[i + 1];
						  total:= total - 1
						end
						else
						begin
							writeln ('Posição não existe em sua lista. Digite uma posição válida!');
							 for i:=1 to total do 
					  		write(' ', i, ' | ');
					  	 write (' < POSIÇÕES ');
					  	writeln;
					  	writeln(' -----------------');
					  	for i:=1 to total do
					  		write( list[i], ' | ');
					  	write (' < NÚMEROS DA LISTA');
							writeln;
							verifica:= false;
						end;
					until ( verifica = true );
			end;
		end;
		                   
Begin
	 repeat
	 		writeln;
	 		writeln ('  --- Menu de Rotinas ---');
	 		writeln ('  -----------------------');
	 		writeln ('  0 - Sair do Programa');
	 	  writeln ('  1 - Inserir na Lista');
	 	  writeln ('  2 - Remover da Lista');
	 	  writeln ('  3 - Consultar Lista');
	 	  writeln ('  -----------------------');
	 	  write('  Escolha a rotina que deseja seguir: ');
	 	  readln ( op );
	 	  writeln;
	 	  if (op in [0, 1, 2, 3]) then
	 	  begin
		 	  case (op) of
		 	      0: writeln ('ENCERRANDO O PROGRAMA...');
		 	  		1: inserir( list );
		 	  		2: remover( list );
		 	  		3: consultar ( list );
		 	  end;
		  end
		  else
		  	writeln ('Opção digita inválida. Digite novamente');
	 until ( op = 0 );
	 writeln;
	 writeln('   Assim ficou sua lista neste momento:');
	 writeln('   -----------------------------------');
	 write ( '   ');
	 for i:=1 to total do
	   		write( list[i], ' | ' );
End.