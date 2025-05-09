Program ex_28 ;

		var num: integer;
				soma:real;

Begin
    num:= 1;
    soma:= 0;
    while num <=20 do
    	begin
    		 soma:= soma + num / (21 - num);
    		 num:= num + 1;
    	end;
    	writeln ('Soma = ' ,soma:6:2);
End.