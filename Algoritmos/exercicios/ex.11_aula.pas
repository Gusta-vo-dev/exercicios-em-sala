Program ex_11 ;

 		var a, b, c: integer;

Begin
    writeln ('Digite o valor de A');
    readln (a);
     writeln ('Digite o valor de B');
    readln (b);
     writeln ('Digite o valor de C');
    readln (c);
    if (a + b) < c then
    	writeln ('A soma de A + B � menor que C!')
    else if (a + b) = c then
    		writeln ('A soma de A + B � igual a C!')
    	else
    		writeln ('A soma de A + B � maior que C!');	
End.