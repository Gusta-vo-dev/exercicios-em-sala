Program ex_17 ;

			var ident: integer;
					n1, n2, n3: real;
					ma, me: real;
Begin
    writeln ('Digite seu número de identificação');
    readln (ident);
		writeln ('Digite suas três notas');
		readln ( n1, n2, n3);
		me:= ( n1 + n2 + n3) div 3;
		ma:= (n1 + n2 * 2 + n3 * 3 + me) / 7;
		writeln ('Número de Identificação: ' ident);
		if ma >= 90 then
			writeln ('Sua nota è a
		