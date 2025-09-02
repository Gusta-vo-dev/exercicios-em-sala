Program ex_06 ;

	 var  i:integer;
	 			a: array[1..10] of integer;
	 			b: array[1..10] of integer;
	 			c: array[1..10] of integer;

Begin
    for i:=1 to 10 do
    begin
    		writeln ('Digite o ', i, 'º elemente do vetor A ( 10 elementos )');
    		readln ( a[i] );
    end;
    writeln ('==================================');
    for i:=1 to 8 do
    begin
    		writeln ('Digite o ', i, 'º elemente do vetor B( 8 elementos)');
    		readln ( b[i] ); 
		end;
		b[9]:=0;
		b[10]:=0;       
    for i:=1 to 10 do
    begin
       c[i]:= a[i] + b[i];
       writeln ('A soma do ', i ,'º elemento dos vetores A e B é: ', c[i]);
		end;  
    
End.