Program ex_33 ;

		var num, mult, resultado: integer;

Begin
   writeln ('Digite um número para calcular a tabuada');
   readln(num); 
   mult:= 0;
   while mult<=10 do
   		begin
   			 resultado:= num * mult;
   			 writeln( num, ' x ', mult, ' = ', resultado);
				 mult:= mult + 1;
   		end;
End.