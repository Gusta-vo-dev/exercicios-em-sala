Program lista_9 ;

	var num: integer;
	
	function verifica ( n: integer): boolean;
	begin
		if n mod 2 = 0 then
			verifica:= true
		else 
			verifica:= false;
	end;
Begin
   write ('Digite um número inteiro: ');
   readln ( num );
   if verifica(num) = true then
   		writeln ('O número ', num, ' é par!')
   else 
   		writeln ('O número ', num, ' é ímpar!');
End.