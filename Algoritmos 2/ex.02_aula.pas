Program ex_02 ; 

	const cont=200;
	var i, valor: integer;
			num: array[1..200] of integer;
			v: array[1..25] of integer;  
		 
Begin
    for i:=1 to cont do 
    	begin
				num[i]:= 1 + random (25);
    		writeln (num[i], ' ');
			end;
		for i:=1 to cont do
			begin 
				valor:= num[i];
				v[valor]:= v[valor] + 1;
			end;
		for i:=1 to 25 do 
			begin
				writeln (' Número ', i, ' são ', v[i]);  
			end;  
End.