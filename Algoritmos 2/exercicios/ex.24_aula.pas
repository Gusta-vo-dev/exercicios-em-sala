Program ex_24 ;

const max = 4;

type
	nete = record
		codigo:integer;
		email: string[20];
		plano: integer;
		horas: integer;
		site: char;
	end;
	
	internet = array[1..max] of nete;
	
	var net : internet;
			valor, custo: real;
			i: integer;
	
Begin
   for 
End.