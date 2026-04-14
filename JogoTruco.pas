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
	  writeln;
	  writeln('          =========================================');
		writeln('          A MANILHA DA RODADA É O: ', manilha);
		writeln('          =========================================');
		writeln;
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
	  jok := baral[7]; // A "vira"
	  inserirForca(baral, jok, manilha);
	  
	  for i := 1 to 6 do
	  begin
	    if (i mod 2 = 1) then
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
	
	procedure mostraCabecalho ( quedasJ, quedasC: integer; manilha: integer);
	begin
	  writeln;
	  writeln('          =========================================');
	  writeln('          A MANILHA DA RODADA É O: ', manilha);
	  writeln('          =========================================');
	  writeln;
		writeln ('          Placar:   Você ', quedasJ, ' x ', quedasC, ' Computador');
	end;
	
	procedure rodada(var maoJ, maoC: iBaralho; manilha: integer );
	var
	  i, escolha, ptsJ, ptsC, quedasJ, quedasC: integer;
	  usadaJ, usadaC: array[1..3] of boolean;
	  cartaJ, cartaC: iCarta;
	begin  
	  for i := 1 to 3 do 
			usadaJ[i] := false;
	  for i := 1 to 3 do 
			usadaC[i] := false;
	  for i := 1 to 3 do
	  begin	   
	    writeln;
	    writeln('          --- ', i, 'ª QUEDA ---');
	    writeln;
	    writeln('          Sua mão:'); 
	    for escolha := 1 to 3 do
	      if not usadaJ[escolha] then
	        writeln('          ', escolha, ': ', maoJ[escolha].carta, ' de ', maoJ[escolha].naipe);
	    repeat
	      write('          Escolha uma carta (1-3): ');
	      readln(escolha);
	    until (escolha in [1..3]) and (not usadaJ[escolha]);	    
	    usadaJ[escolha] := true;
	    cartaJ := maoJ[escolha];
	    escolha := 1;
	    while (usadaC[escolha] = true) do 
			   escolha := escolha + 1;
	    usadaC[escolha] := true;
	    cartaC := maoC[escolha];	
	    writeln('          Voce jogou: ', cartaJ.carta, ' de ', cartaJ.naipe);
	    writeln('          PC jogou: ', cartaC.carta, ' de ', cartaC.naipe);	
	    if cartaJ.forca > cartaC.forca then
	    begin
	      writeln('          >> Você venceu está queda!');
	      quedasJ := quedasJ + 1;
	    end
	    else if cartaC.forca > cartaJ.forca then
	    begin
	      writeln('          >> Computador venceu esta queda!');
	      quedasC := quedasC + 1;
	    end
	    else
	      writeln('          >> Empatou!');	
	    if quedasJ = 2 then break;
	    if quedasC = 2 then break;
	    readkey;
	    ClrScr;
	    mostraCabecalho ( quedasJ, quedasC, manilha );
	  end;
	  writeln('Aguardando você apertar uma tecla para iniciar a próxima rodada...');
		  while not KeyPressed do
		  begin
		    write('.');
		    delay(800);
		  end;
	  writeln('          ---------------------------');
	  if quedasJ > quedasC then 
			writeln('          VOCÊ GANHOU O JOGO!')
	  else if quedasC > quedasJ then 
			writeln('          O COMPUTADOR GANHOU!')
	  else 
			writeln('          O JOGO TERMINOU EMPATADO!');
//	  if quedasJ > quedasC then // Retorna que o Jogador ganhou a mão //
//    	rodada := 1  
//	  else // Retorna que o PC ganhou a mão //
//	    rodada := 2
		
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