Program lista_10 ;

	var n: integer;   
	
	function verifica ( num: integer): boolean;
	begin
		 if (num mod 2 = 0) then
		 		verifica:= true
		 else 
		 		verifica:= false;
	end;                                            
Begin
   write('Digite um número inteiro: ');
   readln ( n );
	 if (verifica(n) = true) then 
	 		writeln ('O número ', n,' é par!')
	 else 
	 		writeln ('O número ', n,' é ímpar!');  
End.