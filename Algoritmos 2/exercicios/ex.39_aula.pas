Program ex_39 ;

	 var num: integer;
	 
	 function verifica(var n: integer ): boolean;
	 var i: integer;
	 begin
	 		if n <= 1 then 
	 			verifica:= false;
			if n = 2 then
				verifica:= true;	
	 		
	 end;

Begin
   writeln('Digite um número inteiro');
   readln ( num );
   if verifica(num) = true then
   		writeln ('O número é primo!')
   else 
   		writeln ('O numero não é primo!');
End.