Program ex_38 ;

	var  n1, n2, n3,m: real; 
			 l: char;
	
	procedure calcula_media ( nota1, nota2, nota3: real; letra: char; var med: real);      
	begin
		letra:= upcase(letra);
		if (letra = 'A') then
				med:= (nota1 + nota2 + nota3) / 3
		else
			if (letra = 'P') then 
				med:= (nota1*5 + nota2*3 + nota3*2) / 10; 
	end;


Begin
   writeln ('Digite suas três notas');
   readln ( n1, n2, n3 );
   writeln ('Você quer calcular a média aritmética ou ponderada? (A- Aritmética P- Ponderada)');
   readln ( l );
   calcula_media ( n1, n2,  n3, l, m);
   if (l = 'A') then
				writeln ('A média Aritmética das 3 notas é: ', m)
		else 
				writeln ('A média Ponderada das 3 notas é: ', m); 
End.