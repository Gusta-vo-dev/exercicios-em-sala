Program ex_05 ;

		var l, c, n: integer;
				a: array [1..5, 1..5] of integer;

Begin
   writeln ('Informe o tamanho da matriz');
   readln ( n );
   for l:= 1 to n do 
   	for c:=1 to n do 
   		 begin 
   			 gotoxy ( c*4, l + 4);
   		 	 read ( a[ l, c ] );
   		end;
   write ('Matriz Inteira');
   for l:= 1 to n do 
   	for c:=1 to n do 
   			begin
   				gotoxy (c*4, l+12);
   			  writeln ( a [l, c]);
   			end;
   write ('Diagonal Principal: ');
   for l:= 1 to n do 
   	for c:=1 to n do 
   			begin
   			  if l = c then
   			   	writeln ( a [l, c]);
   			end;
   write ('Diagonal Segundária: ');
   for l:= 1 to n do 
   	for c:=1 to n do 
   			begin
   			  if l + c = n + 1 then 
   			   	writeln ( a [l, c]);
   			end;
   writeln ('Matriz Superior: ');
   for l:= 1 to n do 
   	for c:=1 to n do 
   			begin
   			  if l < c then 
   			   	writeln ( a [l, c]);
   			end;
   write ('Matriz Inferior: ');
   for l:= 1 to n do 
   	for c:=1 to n do 
   			begin
   			  if l > c then 
   			   	writeln ( a [l, c]);
   			end;
End.