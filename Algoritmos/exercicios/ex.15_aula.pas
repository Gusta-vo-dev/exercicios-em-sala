Program ex__15 ;

		var	 altura: real;
				 sexo: integer;
				 peso: real; 

Begin
     writeln (' Digite a sua altura');
     readln (altura);
     writeln ('Qual o seu sexo? 0- Masculino 	1- Feminino');
     readln ( sexo);
     if sexo = 0 then
     		peso:= (72.7 * altura) - 58
     else if sexo = 1 then
     		peso:= ( 62.1 * altura) - 44.7;
     if (sexo = 0) or ( sexo = 1) then
     		writeln ('O peso ideal é: ', peso:0:2, ' kg');
End.