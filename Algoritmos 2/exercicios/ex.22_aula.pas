Program ex_22 ;

const max = 2;

type
 	reg_niver = record
 		nome:  string[15];
 		dia: integer;
 		mes: integer;
 	end;
 	
 	vet_niver = array[1..40] of reg_niver;
 	
	var lista : vet_niver;
			i, j: integer;	

Begin
   for i:=1 to max do
   with lista[i] do
   begin
   		writeln ('Digite o nome da ', i, '� pessoa: ');
   		read ( nome );
   		writeln ('Digite o dia do anivers�rio: ' );
   		read ( dia );
   		writeln ('Digite o m�s do anivers�rio: ');
   		read( mes );
   end;
   writeln;
   writeln;
   for i:=1 to 12 do
   begin
	   	for j:=1 to max do 
		   	begin
		   	   if (lista[j].mes = i)then
		   	   		writeln ('No m�s ',i,' o(a) ', lista[j].nome,'(',lista[j].dia,'/',lista[j].mes,') faz anivers�rio!');   		
		   	end;
			for j:=1 to 1 do
					if (lista[1].mes <> i) and (lista[2].mes <> i) then
							writeln ('No m�s ', i,' n�o h� ningu�m que faz anivers�rio!');	
	 end;
End.