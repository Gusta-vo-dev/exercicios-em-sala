Program ex_33;

	var raio, result:real;
	
	function calcula_raio ( var r:real) : real;
	begin
		 calcula_raio:= 4/3 * (3.14 * r * r * r);
	end;

Begin
   write ('Digite o raio: ');
   readln ( raio );
   result:= calcula_raio(raio);
	 writeln (result); 
End.