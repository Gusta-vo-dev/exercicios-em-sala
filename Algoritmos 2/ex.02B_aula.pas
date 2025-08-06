Program ex;

	var v: array [1..25] of integer;
	    num, i: integer;

Begin
   for i:= 1 to 200 do 
   	begin 
   		num:= random (25) + 1;
   		v[num]:= v[num] + 1;
   	end;
   for i:=1 to 25 do 
   	writeln (' O número ', i, ' se repete ', v[i], ' vezes');
End.