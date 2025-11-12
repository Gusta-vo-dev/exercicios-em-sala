Program question_6 ;

	var ano, mes, dia, totald: integer;
	
	function idade_dias ( a, m, d:integer): integer;
	begin
		a:= a * 365;
		m:= m * 30;
		idade_dias:= a + m + d;
	end;	
Begin
    writeln('Quantos ANOS de vida você tem?');
    readln( ano );
    writeln ('Quantos MESES de vida você tem?');
    readln ( mes );
    writeln ('Quantos DIAS de vida você tem?');
    readln ( dia );
    totald:= idade_dias ( ano, mes, dia );
    writeln ('O total de dias de sua vida é: ', totald);
End.