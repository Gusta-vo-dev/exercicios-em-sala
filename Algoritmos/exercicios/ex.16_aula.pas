Program ex_16 ;

 	var peso, altura, imc: real;

Begin
    writeln ('Digite seu peso');
    readln (peso);
    writeln ('Digite sua altura);
    readln (altura);
    imc:= peso / ( altura * altura);
    if  imc=  > 18.5 then
    		writeln ('Abaixo do peso')
    else if imc < 18.5 then
    		writeln ('Peso normal')
    else if imc < 25 then
    		writeln ('Acima do peso')
    else 
    		writeln ('Obeso');
End.