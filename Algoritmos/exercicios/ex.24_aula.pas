Program ex_24;

		var i, sucessor, num:integer;

Begin
   writeln ('Digite um Número');
   readln ( num );
   writeln('Os 20 sucessores do número são: ');
   for i:= 1 to 20 do
    begin
			 sucessor:= num + i;
			 writeln (sucessor);
		end;	
End.