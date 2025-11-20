Program lista_20 ;

	var n: integer;
	
	procedure tabuada( num: integer);
	var i, r: integer;
	begin
		 for i:=1 to n do
		 begin
		 		r:= i * n;
		 		writeln ( i,' x ', n , ' = ', r);
		 end;
	end;

Begin
  write ('Digite um número inteiro: ');
  readln ( n );
	tabuada ( n ); 
End.