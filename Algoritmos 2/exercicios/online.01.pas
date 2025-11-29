Program IMC_function ;

	var peso, altura: real;
	
	procedure calcula_imc ( p: real; alt: real);
	var calc: real;
	begin
			calc:= p / ( alt * alt );
			writeln;
			writeln ('Tabela de Condições IMC:');
			writeln ('========================');
			writeln ('Abaixo de 18,5   | Abaixo do peso');         
			writeln ('Entre 18,6 e 24,9 | Peso ideal (parabéns)');    		
			writeln ('Entre 25,0 e 29,9 | Levemente acima do peso');  		
			writeln ('Entre 30,0 e 34,9 | Obesidade grau I');  	
			writeln ('Entre 35,0 e 39,9 | Obesidade grau II (severa)');   
 			writeln ('Maior ou igual a 40 | Obesidade grau III (mórbida)');  
			writeln;
			writeln ('O seu IMC é: ', calc:0:2 );
		  if calc <= 18.5 then
		  	writeln('Abaixo do Peso!')
		  else if calc <=24.9 then
		  	writeln('Peso Ideal, Parabéns!')
		  else if calc <= 29.9 then 
		  	writeln ('Levemente acima do peso!')
		  else if calc <= 34.9 then
		  	writeln ('Obesidade Grau I!')
		  else if calc <= 39.9 then
		  	writeln ('Obesidade Grau II!')
		  else 
		  	writeln ('Obesidade Grau III!');
	end;
Begin
   write ('Digite seu peso: ');
   readln ( peso );
   write ('Digite sua altura: ');
   readln ( altura );
   calcula_imc ( peso, altura);
End.