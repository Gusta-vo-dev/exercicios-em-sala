Program ex_21;

		var l,c, j, maiorl, maiorc: integer;
				a: array[1..3, 1..3] of integer;
				ml, mc: array[1..3] of integer;

Begin                                   
    for l:=1 to 3 do
    	for c:=1 to 3 do 
    	begin
    			gotoxy(c*4, l+6);
    			a[l,c]:= random(20) + 0;
    			write (a[l,c]);
    	end;
    writeln;
    writeln;
End.