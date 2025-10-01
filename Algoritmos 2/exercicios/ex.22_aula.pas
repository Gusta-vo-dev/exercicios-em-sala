Program ex_22 ;

const max = 3;
type
    niver = record
    	nome: string[40];
    	dia: integer;
    	mes: integer;
    end;
    
    vet = array [1..30] of niver;
    
var data: vet;
		i, j: integer;
		
Begin                         
   for i:=1 to max do
   begin
   		write ('Digite o nome da ', i,'ª pessoa: ');
   		readln (data[i].nome);
   		write ('Digite o dia de aniversário: ');
   		readln ( data[i].dia);
   		write ('Digite o mês de aniversário: ');
   		readln (data[i].mes);
   end;
   writeln;
   writeln;
   for i:=1 to 12 do
   	 	for j:=1 to 12 do
   	 	begin 
   	 			if data[j].mes = i then
   	 				writeln ('No mês ', i,' faz aniversário o(a): ', data[j].nome,'(',data[j].dia,'/',data[j].mes,')');
      end;     
End.