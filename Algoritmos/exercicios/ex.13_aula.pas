Program ex_13 ;

		var result, num: integer; 

Begin

	writeln ('Digite um n�mero');
	readln (num);
	if num > 0 then
		result:= num * 2
	else if num < 0 then 
		result:= num * 3;
	writeln ('Resultado � ', result);	
  
End.