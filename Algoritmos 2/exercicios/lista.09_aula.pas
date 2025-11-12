Program question_9 ;

	var num, r: integer;
	
	function verificador ( n: integer):boolean;
	begin
		if ( n >= 0 ) then 
				verificador:= true
		else 
				verificador:= false;
	end;
	
Begin
   write ('Digite um número inteiro: ');
   readln ( num );
   if (verificador(num) = true) then
   		writeln ('Número é positivo!')
   else 
   		writeln ('Número é negativo!');
End.