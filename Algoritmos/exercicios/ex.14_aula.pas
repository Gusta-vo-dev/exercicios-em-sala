Program ex_14 ;

		var a, b, c:integer;

Begin
    
		writeln (' Digite tr�s valores');
		readln (a, b, c);
		if (a >= b) and (a >= c) and (b >= c) then
		    	writeln('A ordem decrescente �', a , b, c)
		else if (a >= b) and (a >=c) and (c >= b) then
		     writeln('A ordem decrescente �', a , c, b)
		else if (b >= a) and (b >= c) and (a >= c) then
		     writeln('A ordem decrescente �', b , a, c)
		else if (b >= a) and (b >= c) and (c >= a) then
		    	writeln('A ordem decrescente �', b , c, a)
		else if (c >= a) and (c >= b) and (a >=b)  then
		    	writeln('A ordem decrescente �', c , a, b)
		else if (c >= a) and (c >= b) and (b >= a) then
		    	writeln('A ordem decrescente �', c , b, a)
End.