Program ex_32 ;

		var i, maior, num: integer;

Begin
   i:= 1;
   maior:= -maxInt;
   while i <= 10 do
   		begin
   			write (' Digite o n�mero ', i, ': ');
				readln(num);
				if num > maior then
					maior:= num;
			  i:= i + 1	
			end;
		writeln(' O maior n�mero digitado �: ', maior);
End.