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
	
	procedure inserirForca ( var baral: iBaralho; jok: iCarta);
	var  i, manilha: integer;
	begin
	  case jok.carta of //Defini o manilha//
        1..6: manilha := jok.carta + 1;
        7:    manilha := 10; 
        10:   manilha := 11; 
        11:   manilha := 12; 
        12:   manilha := 1; 
        1:    manilha := 2;  
        2:    manilha := 3; 
        3:    manilha := 4;  
    end;
    for i := 1 to 40 do
    begin
        case baral[i].carta of  //Atribuí força as cartas//
            4: baral[i].forca := 1;
            5: baral[i].forca := 2;
            6: baral[i].forca := 3;
            7: baral[i].forca := 4;
            10: baral[i].forca := 5;
            11: baral[i].forca := 6; 
            12: baral[i].forca := 7; 
            1: baral[i].forca := 8; 
            2: baral[i].forca := 9;  
            3: baral[i].forca := 10; 
        end;
	   	if (baral[i].carta = manilha) then//Atribiu força especial à manilha//
        begin
            if baral[i].naipe = 'Ouro'    then
							baral[i].forca := 11;
            if baral[i].naipe = 'Espadas' then
							baral[i].forca := 12;
            if baral[i].naipe = 'Copas'   then
							baral[i].forca := 13;
            if baral[i].naipe = 'Paus'    then 
						  baral[i].forca := 14;
        end;
    end;
		writeln;    
		write ('			A MANILHA DA RODADA É O: ', manilha ); 
		writeln;
	end;

  procedure corteBaralho ( var baral: iBaralho; var corte: integer );
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

	procedure darCartas ( var baral: iBaralho; var maoJ, maoC: iBaralho; var jok: iCarta);
	var i, posiJ, posiC, corte:integer;
	begin
		 posiJ:= 1;
		 posiC:= 1;
		 corteBaralho ( baral, corte );
		 jok:= baral[7];
		 inserirForca ( baral, jok );
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
		     writeln;
		     writeln('			Sua mão ficou assim: ');
		     writeln('			---------------------------');
		     write('			');
		     for i:=1 to 3 do 
		     begin
		     		write (maoJ[i].carta, ' de ', maoJ[i].naipe, '  |  ');
		     end;
		     writeln;
	end; 
	
	
	var  //Variável para o Baralho Geral//
			baralho: iBaralho;
		
	var  //Variáveis para dar cartas//
			maoJogador: iBaralho;
			maoComputador: iBaralho;
			joker: iCarta;
			
			
			
		//CÓDIGO PARA VERIFICAR QUEM GANHOU A RODADA//	
	  //if cartaJogador.forca > cartaComputador.forca then
    //writeln('Você ganhou essa queda!')
		//else
    //writeln('O computador ganhou essa queda!');
    
Begin
  inserirBaralho(  baralho );
  embaralhar(baralho);
  darCartas ( baralho, maoJogador, maoComputador, joker);
  readln;
  writeln 
End.