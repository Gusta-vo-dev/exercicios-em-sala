Program ex_03;

		var       

Begin
		 for 
  	 begin
  	 	if casa = times + 1 then // Controla para não ultrapassar a quantidade de times
  	 			casa:=  2;
  	 	if visitante = 1 then //Controla para que o visitante não seje 1
  	 			visitante = times;
  	 	if i mod 2 = 1 then 
  	 			writeln ( casa:2, ' x ', visitante:2)
  	 	else 
  	 			writeln (visitante:2, ' x ', casa:2);
  	 	if casa = 1 then // Gera o time da casa do segundo jogo da rodada 
  	 			casa:= visitante + 1;
  	 	else 
			 		casa:= casa + 1;
			visitante := visitante - 1;
			end;		
End.