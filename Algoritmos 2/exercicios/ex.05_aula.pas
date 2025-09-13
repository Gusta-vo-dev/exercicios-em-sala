Program ex_05 ;

		var i, num, j, qntd:integer;
				a: array[1..10] of integer;
				b: array[1..10] of integer;
Begin
	 //digita qntd
	 writeln ('Digite a quantidade de elementos do vetor ( MÁX = 10 )');
	 readln ( qntd );
	 for i:=1 to qntd do
	 begin
	 		writeln;
	 		//digita numeros do vetor A
	 		writeln ('Digite o ', i, 'º número do vetor');
	 		readln ( num );
	 		a[i]:= num;
				 //verifica se elemento está no vetor
				 for j:=1 to qntd do
				 begin
				 		if num = a[j] then
				 			b[j]:= a[j];
				 end;
	end;	
	for i:=1 to qntd do
  begin
  		writeln ('Números digitados: ', a[i] );
			writeln ('Números repetidos: ', b[i] );
	end;		 		
End.