Program JogoTruco ;

  type
	iCarta = record 
			carta: integer;
			naipe: string;
			forca: integer;
		end;
		iBaralho = array[1..40] of iCarta;
		
	
	procedure inserirBaralho (var baral: iBaralho);
	var i, n, x, poder: integer;
	    naipes: array[1..4] of string;
	    cartas: array[1..10]of integer;
	begin
			naipes[1]:= 'Paus';
			naipes[2]:= 'Copas';
			naipes[3]:= 'Espadas';
			naipes[4]:= 'Ouro';
			x:=1;
			for i:=1 to 12 do 
				 for n:=1 to 4 do
				 begin
				 		with baral[x] do
				 		begin
				 				if ( i < 8) or (i > 9) then
				 				begin
								 	  carta:=i; 								
								 	  naipe:= naipes[n];
								 	  forca:= x;
								 	  x:= x + 1;
								end;
						end;
				end;	 
	end; 
	
	procedure embaralhar(var baral: iBaralho);
	var
	  i, j: integer;
	  temp: iCarta; 
	begin
	  Randomize;
	  for i := 40 downto 1 do
	  begin
	    j := Random(i) + 1;
	    temp := baral[i];
	    baral[i] := baral[j];
	    baral[j] := temp;
	  end;
	end;
	
	var baralho: iBaralho;
			cont: integer;
	
Begin
  inserirBaralho(  baralho );
  embaralhar(baralho);
  for cont:=1 to 40 do
  begin
  	with baralho[cont] do
  	begin
			writeln ( ' ', carta,' de ', naipe);
		end;
  end;
  readln;
End.