Program ex_14 ;

		var a, b, c:integer;

Begin
    
		writeln (' Digite três valores');
		readln (a, b, c);
		if (a >= b) and (a >= c) and (b >= c) then
		    	writeln('A ordem decrescente é', a , b, c)
		else if (a >= b) and (a >=c) and (c >= b) then
		     writeln('A ordem decrescente é', a , c, b)
		else if (b >= a) and (b >= c) and (a >= c) then
		     writeln('A ordem decrescente é', b , a, c)
		else if (b >= a) and (b >= c) and (c >= a) then
		    	writeln('A ordem decrescente é', b , c, a)
		else if (c >= a) and (c >= b) and (a >=b)  then
		    	writeln('A ordem decrescente é', c , a, b)
		else if (c >= a) and (c >= b) and (b >= a) then
		    	writeln('A ordem decrescente é', c , b, a)
End.