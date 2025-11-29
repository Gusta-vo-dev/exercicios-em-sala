Program  lista_03;

	var num: integer;
	
	function verifica_primo ( n: integer): boolean;
	var i, cont: integer;
	begin
		 cont:= 0;
		 if n = 2 then
		 		verifica_primo:= true
		 else if n = 1 then
		 		verifica_primo:= false
		 else 
		 begin
			  for i:=1 to n div 2 do
			   		if n mod i = 0 then
			   				cont:= cont + 1;
			  if cont > 1 then
			   		verifica_primo:= false
			  else 
	   				verifica_primo:= true;
	  end; 				
	end;
Begin
   write ('Digite um número positivo e inteiro: ');
   readln ( num );
	 if verifica_primo(num) = true then 
	 		Writeln ('O número ', num,' é primo!')
	 else 
	 		writeln ('O número ', num,' não é primo!');
End.