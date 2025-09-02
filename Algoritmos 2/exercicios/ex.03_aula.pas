Program ex_03 ;

		var rodada, jogos, j, i, casa, times, visitante: integer;

Begin 
		 writeln ('Informe a quantidade de times do campeonato');
		 readln ( times );
     rodada:= times;
     jogos:= times div 2;
     for i:=1 to rodada do
     begin
     		writeln('Rodada ', i);
     		writeln ('');
     		casa:= i + 1;
     		visitante:= i - 1;
     		for j:=1 to jogos do
     		begin
     				if casa = times + 1 then
     					casa:= 1;
     				if visitante = 0 then
     					visitante:= times;
     				if j mod 2 = 1 then 
     				 writeln ( casa:2, ' x ', visitante:2)
     				else 
     					writeln (visitante:2, ' x ', casa:2);
     				casa:= casa + 1;
     				visitante:= visitante - 1;
     		end;
     		writeln ('============')
     end;
End.