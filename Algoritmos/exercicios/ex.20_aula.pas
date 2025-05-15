Program ex_34 ;

		var gol1, gol2: integer;
        time1, time2: string;
Begin
    writeln('Nome do time 1');
    readln(time1);
    writeln('Nome do time 2');
    readln(time2);
    writeln('Gols do time 1');
    readln(gol1);
    writeln('Gols do time 2');
    readln(gol2);
    if gol1> gol2 then
    	writeln (time1, ' é o vencedor')
    else if gol1 < gol2 then
    	writeln (time2, ' é o vencedor')
    else
    	writeln('A partida terminou empatada');
End.