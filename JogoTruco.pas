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
			writeln('			BARALHO INICIADO E EMBARALHADO. BORA PRO JOGO MARRECO!');
			writeln;
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
	
	procedure corteBaralho ( var baral: iBaralho; var corte: integer ) ;
	var i, x: integer;
			novoBaralho: iBaralho;
	begin
			x:= 1;
			write ('			Digite em qual posição você quer cortar o baralho(1 à 40): ');
			readln ( corte );
			for i:=corte to 40 do
			begin
					novoBaralho[x]:= baral[i];
					x:= x + 1;
			end; 
			for i:=1 to (corte - 1) do 
			begin
					novoBaralho[x]:= baral[i];
					x:= x + 1;
			end;
			baral:= novoBaralho;
	end;
	
	//procedure inserirForca ( baral: iBaralho; var forc: iBaralho; jok: iCarta);
	//var  i: integer;
	//begin
	   
	//end
	
	procedure darCartas ( var baral: iBaralho; var maoJ, maoC: iBaralho; var jok: iCarta);
	var i, posiJ, posiC, corte:integer;
	begin
		 posiJ:= 1;
		 posiC:= 1;
		 corteBaralho ( baral, corte );
		 		 for i:=1 to 6 do
		 		 begin
		     		if ( corte mod 2 = 1) then
		     		begin
		    				maoJ[posiJ]:= baral[i];
		    				posiJ:= posiJ + 1;
		    		end
		    		else 
		    		begin
		    				maoC[posiC]:= baral[i];
		    				posiC:= posiC + 1;
		    		end;
		    		corte:= corte + 1;
		     end;
		     jok:= baral[7];
		     writeln;
		     writeln('			Sua mão ficou assim: ');
		     writeln('			---------------------------');
		     write('			');
		     for i:=1 to 3 do 
		     begin
		     		write (maoJ[i].carta, ' de ', maoJ[i].naipe, '  |  ');
		     end;
		     writeln;
		     writeln;
		     writeln;
				 writeln ('			A que vira pra coringa é: ', jok.carta, ' de ', jok.naipe);
				 //inserirForca ( baral, forc, jok);
	end; 
	
	
	
	var  //Variável para o Baralho Geral//
			baralho: iBaralho;
		
	var  //Variáveis para dar cartas//
			maoJogador: iBaralho;
			maoComputador: iBaralho;
			joker: iCarta;
			
	
Begin
  inserirBaralho(  baralho );
  embaralhar(baralho);
  darCartas ( baralho, maoJogador, maoComputador, joker);
  readln;
End.