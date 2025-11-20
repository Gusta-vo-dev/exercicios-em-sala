Program lista_18 ;

	var num, result: integer;
	
	function calc_fat ( var n : integer): integer;
	var i, r: integer;
	begin
	  r:= n;
		for i:=1 to ( n -1) do 
				r:= r * i;
		calc_fat:= r;
	end;

Begin
   writeln ('Digite um número para calcular o fatorial');
   readln ( num );
   result:= calc_fat ( num );
   writeln ('O resulta é: ', result);
End.