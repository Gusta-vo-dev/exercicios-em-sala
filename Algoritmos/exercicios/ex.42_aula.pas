Program ex_42 ;
		const max= 2;
		var i, qntd: integer;
				num: array[1..max] of integer;

Begin
   for i:=1 to max do
	 		begin
			 	writeln (' Digite um número ');
				readln( num[i] );
				if(num[i] mod 2 = 0) then
				qntd:=qntd+1 ;
			end;
			writeln('Quantidade de pares = ',qntd);
	 for i:=1 to max do
	 	begin
	 		if (num[i] mod 2) = 0 then
	 				writeln ('O número ',num[i] ,' é par');
	 	end;
End.