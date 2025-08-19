Program ex_matrizes ;

		var l, c, n: integer;
				a: array [1..5, 1..5] of integer;

Begin
    writeln ('Informe o tamanho da matriz');
    readln ( n );
    for l:=1 to n do 
    	for l:= 1  to n do
    	begin 
    			gotoxy (c*4, l + 4);
    			readln ( a[l + c]);
    	end;
     for l:=1 to n do 
    	for l:= 1  to n do
    	begin 
    			gotoxy (c*4, l + 12);
    			readln ( a[l + c]);
    	end;
End.