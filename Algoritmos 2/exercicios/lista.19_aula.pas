Program lista_19;

	type 
	  num = array[1..50] of integer;

	var numero: num;
			i: integer;
	
	procedure acha_maior ( n: num );
	var maior, menor: integer;
	begin
		maior:= 0;
		menor:= 999;
		for i:=1 to 50 do
		begin
			 if n[i] > maior then
					maior:= n[i];
			 if n[i] < menor then
					menor:= n[i];
		end;
		writeln;
		writeln;
		writeln ('O maior número sorteado é: ', maior);
		writeln;
		writeln;
		writeln ('O menor número sorteado é: ', menor);
	end;

Begin
   for i:=1 to 50 do
   begin
   		numero[i]:= random(100) + 1;
			write (' ', numero[i], ' ');
   end;
   acha_maior ( numero );
End.