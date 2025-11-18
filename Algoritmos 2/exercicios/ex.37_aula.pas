Program ex_37 ;

	 var raio, result: real;
	 
	 function volume ( r: real ): real;
	 begin
	 		volume:= (4*3.14*r*r*r)/3;
	 end;

Begin
   writeln('Digite o raio para calcular o volume');
   readln ( raio );
   result:= volume(raio);
   writeln;
   writeln;
   writeln ('O volume é: ', result);
End.