Program ex_34 ;  

		var num, cont, i:  integer;
				soma: real;
Begin
   writeln ('Digite um valor inteiro e positivo');
   readln(num);
   cont:=0;
   soma:=0;
   i:=1;
   while cont <= num do
   		begin
   			 cont:= cont + 1;
				 soma:= soma + ( i div cont);
			end;
	 writeln('A soma total vai ser: ', soma);
   			
End.