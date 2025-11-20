Program lista_8 ;

	var idade: integer;
			categoria: string[16];
	
	procedure verifica ( idad: integer; var categ: string[16]);
	begin
	     if idad > 17 then
	   				categ:= 'Adulto'
	     else if idad > 13 then
		 				categ:= 'Juvenil B'
	     		else if idad > 10 then
		 					categ:= 'Juvenil A'
	    		else if idad > 7 then
		 					categ:= 'Infatil B'
	    		else if idade > 5 then
		 					categ:= 'Infantil A'
		 			else 
		 					categ:= 'Não Classificado';
	end;

Begin
   write('Digite a sua idade: ');
   readln ( idade );
   verifica ( idade, categoria );
   writeln('A sua categoria de acordo com a sua idade(',idade,') é: CATEGORIA: ', categoria);
End.