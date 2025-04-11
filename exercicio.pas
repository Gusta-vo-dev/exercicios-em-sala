Program Ex_SE ;

		var num:integer;

Begin
    writeln ('informe três números inteiros');
    readln (a, b, c);
    if (a > b) and ( a > c) then
    		writeln (a, 'é maior que',b);
    		writeln (a, 'é maior que' ,c)
    else
    		writeln (a, 'é menor que' ,b);
    		writeln (a, 'é menor que' ,c);
    writeln ('Fim do Programa');
End.