Program ex_27 ;

		var soma, num: integer;

Begin
		soma:=0;
    num:=1;
    while num<=100 do
    	begin	
    		soma:= soma + num;
				num:=  num + 1;
			end;
		writeln ('Soma = ', soma); 
End.