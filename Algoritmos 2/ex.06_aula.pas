Program ex_06 ;

		var va: array [1..10] of integer;
				vb: array [1..8] of integer;
				vc: array [1..10] of integer;
				i, n, m: integer;

Begin
    writeln ('Digite a quantidade de elementos para o vetor A( m�x = 10 )!');
    readln ( n );
    writeln ('Digite a quantidade de elementos para o vetor B ( m�x = 8 )!');
    readln ( m );
    i:= 1;
    while i < 11 do
    begin
		  		writeln ('Digite o ', i ,'� n�mero para o vetor A: ');
		  		readln ( va[i] );
		  		i:= i + 1;
    end;
    while i < 9 do
	    begin
			  	writeln ('Digite o ', i ,'� n�mero para o vetor B: ');
			  	readln ( va[i] );
			  	i:= i + 1;
	    end;
	  for i:=1 to 11 do 
	  begin
	  	vc[i]:= va[i] + vb[i];
			writeln ('Vetor C: ', vc[i]);
	  end;
	  
End.