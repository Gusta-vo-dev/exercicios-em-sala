Program ex_24;

		var i, sucessor, num:integer;

Begin
   writeln ('Digite um N�mero');
   readln ( num );
   writeln('Os 20 sucessores do n�mero s�o: ');
   for i:= 1 to 20 do
    begin
			 sucessor:= num + i;
			 writeln (sucessor);
		end;	
End.