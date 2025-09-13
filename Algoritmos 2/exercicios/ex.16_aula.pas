Program ex_16 ;

		var  l, c:integer;
					m: array[1..5, 1..5] of integer;
					vl, vc: array[1..5, 1..5] of integer;

Begin
    for l:=1 to 5 do
        for c:=1 to 5 do 
        		begin
        				m[l,c]:= random(10);
        				vl:= vl + a[l,c];
        				vc:= vc + a[l,c];
        	  end;
        	  
    writeln('=========================');
		for l:=1 to 5 do
			for c:=1 to 5 do
			begin
					
			end;  
End.