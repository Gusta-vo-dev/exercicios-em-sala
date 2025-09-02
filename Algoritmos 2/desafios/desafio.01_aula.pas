Program desafio_01 ;

		var l, c, maior:integer;
				a:array[1..4, 1..4] of integer;

Begin
    for l:=1 to 4 do
    begin
     maior:= a[1, 1];
    	for c:=1 to 4 do 
    	begin
    		a[l, c]:= random(17);
    		write ( a[l, c]:4);
    	end;
     end;
		for l:=1 to 4 do
			for c:=1 to 4 do 
			begin
					if a[l, c] > maior then
						maior:= a[l, c];
			end;
		writeln;
		writeln('O maior número da matriz é: ', maior);
End.