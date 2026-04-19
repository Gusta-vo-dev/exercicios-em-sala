Program JogoTruco;

	uses crt;

	type
	  iCarta = record 
	    carta: integer;
	    naipe: string;
	    forca: integer;
	  end;
	  iBaralho = array[1..40] of iCarta;
	
	procedure inserirBaralho(var baral: iBaralho);
	var i, n, x: integer;
	    naipes: array[1..4] of string;
	begin
	  writeln('          BARALHO INICIADO E EMBARALHADO. BORA PRO JOGO!');
	  writeln;
	  naipes[1]:= 'Paus'; naipes[2]:= 'Copas';
	  naipes[3]:= 'Espadas'; naipes[4]:= 'Ouro';
	  x:= 1;
	  for i:= 1 to 12 do 
	    for n:= 1 to 4 do
	    begin
	      if (i < 8) or (i > 9) then
	      begin
	        baral[x].carta := i;
	        baral[x].naipe := naipes[n];
	        x := x + 1;
	      end;
	    end;
	end;
	
	procedure embaralhar(var baral: iBaralho);
	var i, j: integer; temp: iCarta;
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
	
	procedure inserirForca(var baral: iBaralho; jok: iCarta; var manilha: integer);
	var i: integer;
	begin
	  // Lógica da Manilha (Próxima carta após a vira)
	  case jok.carta of
	    7:  manilha := 10; 
	    10: manilha := 11; 
	    11: manilha := 12; 
	    12: manilha := 1; 
	    3:  manilha := 4;
	    else manilha := jok.carta + 1;
	  end;
	
	  for i := 1 to 40 do
	  begin
	    case baral[i].carta of
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
	
	    if (baral[i].carta = manilha) then
	    begin
	      if baral[i].naipe = 'Ouro'    then baral[i].forca := 11;
	      if baral[i].naipe = 'Espadas' then baral[i].forca := 12;
	      if baral[i].naipe = 'Copas'   then baral[i].forca := 13;
	      if baral[i].naipe = 'Paus'    then baral[i].forca := 14;
	    end;
	  end;
	end;
	
	procedure corteBaralho(var baral: iBaralho; var corte: integer);
	var i, x: integer; 
			novoBaralho: iBaralho;
	begin
	  x := 1;
	  repeat
	    write('          Digite a posicao para cortar (1 a 40): ');
	    readln(corte);
	  until (corte >= 1) and (corte <= 40);
	  
	  for i := corte to 40 do
	  begin
	    novoBaralho[x] := baral[i];
	    x := x + 1;
	  end; 
	  for i := 1 to (corte - 1) do 
	  begin
	    novoBaralho[x] := baral[i];
	    x := x + 1;
	  end;
	  baral := novoBaralho;
	end;
	
	procedure darCartas(var baral: iBaralho; var maoJ, maoC: iBaralho; var jok: iCarta; var manilha: integer);
	var i, posiJ, posiC, corte: integer;
	begin
	  posiJ := 1; posiC := 1;
	  corteBaralho(baral, corte);
	  jok := baral[7]; //A "vira" da manilha//
	  inserirForca(baral, jok, manilha);
	  
	  for i := 1 to 6 do
	  begin
	    if (i mod 2 = 1) then  //Condição para alternar quem começa recebendo as cartas//
	    begin
	      maoJ[posiJ] := baral[i];
	      posiJ := posiJ + 1;
	    end
	    else 
	    begin
	      maoC[posiC] := baral[i];
	      posiC := posiC + 1;
	    end;
	  end;
	end;
	
	procedure truco(var pontos_rodada: integer; var quemTrucou: string; quemPede: string; fugiu: boolean);
	var
	  opcao, aux_pontos, s: integer;
	  aux_quenPede, adversario: string;
	begin	
	  fugiu:= false;
		if pontos_rodada = 1 then
			aux_pontos:= 3
		else
			aux_pontos:= pontos_rodada + 3;  
		if ( quemTrucou = 'J' ) then
		begin
			 adversario:= 'Computador';
			 s:= random(3) + 1;
			 if s = 1 then
			 begin
			 		pontos_rodada:= aux_pontos;
		      writeln('          Jogo aceito! Valendo ', pontos_rodada);
			 end
			 else if s = 2 then
			 begin
			 		fugiu := true;
		      writeln('          ' ,adversario, ' correu! O Computador leva a rodada.');
			 end
			 else if ( s = 3 ) and ( pontos_rodada < 9 ) then
			 begin
			    pontos_rodada:= aux_pontos;
						 aux_pontos:= aux_pontos + 3; 
						 quemTrucou:= 'C';      
		         quemTrucou := quemPede;
		         if quemPede = 'C' then 
		            truco(pontos_rodada, quemTrucou, quemPede, fugiu)
		         else 
		            truco(pontos_rodada, quemTrucou, quemPede, fugiu);
			 end;
		end;
		if ( quemTrucou = 'C' ) then
		begin
			adversario:= 'Você';
			writeln;
			writeln('          --- O COMPUTADOR PEDIU TRUCO! ---');
			writeln('          --- O que deseja fazer? ---');
			write('          1 - Aceitar   2 - Correr  ');
			if pontos_rodada < 9 then
					writeln(' 3 - Pedir ', aux_pontos + 3);
			repeat
			    write('          Escolha: ');
			    readln(opcao);
			  until (opcao in [1, 2]) or ((opcao = 3) and (pontos_rodada < 9));
		  case opcao of
		    1: begin //Opção para aceitar//
		         pontos_rodada:= aux_pontos;
		         writeln('          Jogo aceito! Valendo ', pontos_rodada);
		       end;
		    2: begin //Opção para correr//
		         fugiu := true;
		         writeln('          ' ,adversario, ' correu! O Computador leva a rodada.');
		       end;
		    3: begin //Opção para retrucar//
		         pontos_rodada:= aux_pontos;
						 aux_pontos:= aux_pontos + 3; 
						 quemTrucou:= 'J';      
		         quemTrucou := quemPede;
		         if quemPede = 'J' then 
		            truco(pontos_rodada, quemTrucou, quemPede, fugiu)
		         else 
		            truco(pontos_rodada, quemTrucou, quemPede, fugiu);
		       end;
			end;
		end;
	end; 
	
	procedure mostraCabecalho ( quedasJ, quedasC: integer; manilha, pontos_rodada: integer);
	begin
	  writeln;
	  writeln('          =========================================');
	  writeln('          A MANILHA DA RODADA É O: ', manilha);
		writeln('          Placar da Rodada:   Você ', quedasJ, ' x ', quedasC, ' Computador');
		writeln('          Rodada Valendo: ', pontos_rodada);
	  writeln('          =========================================');
	  writeln;
	end;
	
	procedure rodada(var maoJ, maoC: iBaralho; manilha: integer);
	var
	  i, escolha, pontosJ, pontosC, quedasJ, quedasC, pontos_rodada, sortTrucoC, condEmpate, vale_terceira, xJ, xC, quemInicia: integer;
	  usadaJ, usadaC: array[1..3] of boolean;
	  cartaJ, cartaC: iCarta;
	  quemComeca, fugiu: boolean;
	  quemTrucou, quemPede, primeira_queda: string;
	begin 
	  condEmpate:= 0;
	  pontos_rodada:= 1;
	  quedasJ:= 0; 
		quedasC:= 0;
	  for i := 1 to 3 do 
			usadaJ[i] := false;
	  for i := 1 to 3 do 
			usadaC[i] := false;
		quemInicia:= random(2) + 1;
  	if ( quemInicia mod 2 = 0 ) then
		  quemComeca:= true
		else 
			quemComeca:= false;
		quemPede:= 'N';
	  for i := 1 to 3 do
	  begin
		  mostraCabecalho ( quedasJ, quedasC, manilha, pontos_rodada );	   
	    writeln;
	    writeln('          --- ', i, 'ª QUEDA ---');
	    if (quemComeca = true) then
	    begin
			    writeln;
			    writeln('          Sua mão:');         
			    for escolha := 1 to 3 do
			      if not usadaJ[escolha] then
			        writeln('          ', escolha, ': ', maoJ[escolha].carta, ' de ', maoJ[escolha].naipe);
			      if (quemPede = 'C') or (quemPede = 'N') then
							writeln ('          4: Trucar');
			    repeat
			      write('          Escolha uma opção: ');
			      readln(escolha);
			      if escolha = 4 then
			      begin
							quemPede:= 'J';      	
						  quemTrucou:= 'J';
			      	truco( pontos_rodada, quemTrucou, quemPede, fugiu);
							if fugiu = true then
			      		break; 
			      end;
			    until (escolha in [1..4]) and (not usadaJ[escolha]);	    
			    usadaJ[escolha] := true;
			    cartaJ := maoJ[escolha];
			  
				  if (quemPede = 'J') or (quemPede = 'N') then
				  begin
					  if quedasC = 0 then //Condições para Computador pedir truco//
							sortTrucoC:= random(5) + 1
						else
							sortTrucoC:= random(4) + 2;
				    if sortTrucoC = 4 then
				    begin
				    	quemPede:= 'C';
				    	quemTrucou:= 'C';
				    	truco( pontos_rodada, quemTrucou, quemPede, fugiu);
				    	if fugiu = true then
			      		break;
				    end;
				  end;
			    escolha := 1;
			    while (usadaC[escolha] = true) do 
					   escolha := escolha + 1;
			    usadaC[escolha] := true;
			    cartaC := maoC[escolha];
			    writeln;
			    writeln('          Voce jogou: ', cartaJ.carta, ' de ', cartaJ.naipe);
			    writeln;
			    writeln('          PC jogou: ', cartaC.carta, ' de ', cartaC.naipe);
					writeln;
			end
			else //Condição caso quem começa seja o computador//
			begin
			    writeln('          Sua mão:');         
			    for escolha := 1 to 3 do
			      if not usadaJ[escolha] then
			        writeln('          ', escolha, ': ', maoJ[escolha].carta, ' de ', maoJ[escolha].naipe);
						  if (quemPede = 'C') or (quemPede = 'N') then
								writeln ('          4: Trucar');
			    if (quemPede = 'J') or ( quemPede = 'N' ) then
			    begin
						if quedasC = 0 then //Condições para Computador pedir truco//
								sortTrucoC:= random(4) + 1
							else
								sortTrucoC:= random(4) + 2;
					    if sortTrucoC = 4 then
					    begin
					    	quemPede:= 'C';
					    	quemTrucou:= 'C';
					    	truco( pontos_rodada, quemTrucou, quemPede, fugiu);
					    	if fugiu = true then
			      		break;
					    end;
					end;
			    escolha := 1;
			    while (usadaC[escolha] = true) do 
					   escolha := escolha + 1;
			    usadaC[escolha] := true;
			    cartaC := maoC[escolha];
			    writeln;
			    writeln('          PC jogou: ', cartaC.carta, ' de ', cartaC.naipe);
					writeln;
			  
			    repeat
			      write('          Escolha uma opção: ');
			      readln(escolha);
			      if escolha = 4 then
			      begin	     	
						  quemTrucou:= 'J';
			      	truco( pontos_rodada, quemTrucou, quemPede, fugiu);
			      	if fugiu = true then
			      		break;
			      end;
			    until (escolha in [1..4]) and (not usadaJ[escolha]);	    
			    usadaJ[escolha] := true;
			    cartaJ := maoJ[escolha];
			    writeln;
					writeln('          Você jogou: ', cartaJ.carta, ' de ', cartaJ.naipe);
			    writeln;
			end;
						
	    if cartaJ.forca > cartaC.forca then
	    begin
	      writeln('          >> Você venceu essa queda!');
	      quedasJ := quedasJ + 1;
	      quemComeca:= true;
	      if ( i = 1) then
	      	primeira_queda:= 'J';
	    end
	    else if cartaC.forca > cartaJ.forca then
	    begin
	      writeln('          >> Computador venceu essa queda!');
	      quedasC := quedasC + 1;
	      quemComeca:= false;
	      if ( i = 1 ) then
	      	primeira_queda:= 'C';
	    end
	    else
	    begin
	      writeln('          >> Empatou!');
				quedasC := quedasC + 1;
				quedasJ := quedasJ + 1;
				condEmpate:= condEmpate + 1;	
	    end;
	    if condEmpate = 1 then
	    	quemComeca:= not quemComeca
	    else
	    	quemComeca:= quemComeca;
	    	
			if ( i = 3 ) and ( quedasC = quedasJ ) then
			begin
				 if primeira_queda = 'C' then
				 		pontosC:= pontos_rodada
				 else
				    pontosJ:= pontos_rodada;
				 break;
			end 
			else
			begin
		    if CondEmpate = 2 then
		    	 vale_terceira:= 3
		    else
		    	vale_terceira:= 2;
		    if quedasJ = vale_terceira then 
		    begin
		    	pontosJ:= pontos_rodada;
					break;
				end;
		    if quedasC = vale_terceira then 
		    begin
		    	pontosC:= pontos_rodada;
					break;
				end;
			end;
				
	    readkey;
	    ClrScr;
	  end;
	  
	  if quedasJ > quedasC then 
			writeln('          VOCÊ GANHOU O JOGO!')
	  else 
			writeln('          O COMPUTADOR GANHOU!');
			
	  writeln('Aguardando você apertar uma tecla para iniciar a próxima rodada...');
		  readkey;
	  writeln('          ---------------------------');		
	end;
	
	
	var
	  baralho: iBaralho;
	  maoJogador: iBaralho;
	  maoComputador: iBaralho;
	  joker: iCarta;
	  manilha: integer;
	
Begin
  inserirBaralho(baralho);
  embaralhar(baralho);
  darCartas(baralho, maoJogador, maoComputador, joker, manilha);
  rodada(maoJogador, maoComputador, manilha);
End.