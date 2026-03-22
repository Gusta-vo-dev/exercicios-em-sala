Program JogoTruco ;

	var baralho: iBaralho;

	type 
	iCarta = record 
			carta: string;
			naipe: integer;
			poder: integer;
		end;
	iBaralho: array[1..40] of iCarta;
	
	procedure inserirBaralho (var baral: iCarta);
	var i, n: integer;
	begin
			for i:=1 to 10 do 
 			with baral[i] do
			begin
				 carta:= i;
				 for n:=1 to 4 do
				 	 
			end;
	end; 
	
	
	
Begin
  
End.