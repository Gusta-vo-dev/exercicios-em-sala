Program ex_10 ;

		var num, divisao, resto:integer;

Begin
    writeln ('Informe um n�mero');
    readln (num);
    divisao:= num div 2;
    resto:= num - divisao * 2;
    if resto = 0 then
    	writeln (num, ' � par')
    else
    	writeln (num, ' � impar');
    	
End.