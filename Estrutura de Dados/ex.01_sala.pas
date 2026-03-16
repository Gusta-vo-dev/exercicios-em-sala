Program Program_1 ;

const max=3;

type 
	vet = array[1..max] of integer;
	
var fila: Tfila;


	procedure iniciar( var f: Tfila);
	begin
			f.inicio:= 1;
			f.fim:= 0;
	end; 
	
	procedure inserir ( var f: Tfila; valor: integer);
	begin
	   if f.fim = max then
	   		writeln('A fila está cheia!')
	   else
	   begin
	   		if f.inicio = 0 then 
				 	f.inicio:= 1;
				f.fim:= f.fim + 1;
				f.dados[f.fim]:= valor;
	   end;		
	end;

Begin
  	inserir( 
  	
End.