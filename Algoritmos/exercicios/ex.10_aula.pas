Program ex_10 ;

		var num, divisao, resto:integer;

Begin
    writeln ('Informe um número');
    readln (num);
    divisao:= num div 2;
    resto:= num - divisao * 2;
    if resto = 0 then
    	writeln (num, ' é par')
    else
    	writeln (num, ' é impar');
    	
End.