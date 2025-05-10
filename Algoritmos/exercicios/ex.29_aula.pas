Program ex_29;

		var num, i, fatorial: integer;

Begin                  
		writeln (' Digite um Valor');
		readln ( num );
		i:= 1;
		fatorial:= 1;
		while i <= num do 
			begin 
				fatorial:= fatorial * i;
				i:= i + 1;
			end;
  	writeln (' O fatorial de ', num, ' e : ', fatorial);
End.