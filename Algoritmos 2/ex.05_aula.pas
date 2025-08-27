Program ex_05;

		var i, j, n, repetiu: integer;
		    v: array[1..10] of integer;

Begin
    i:=1;
		while i<=10 do
			begin 
					writeln ('Digite um número inteiro');
					readln( n );
					for j:=1 to i - 1 do
						begin
							 if v[j] = n then 
							 		repetiu:= 1;
						end;
					if repetiu = 1 then
						begin
								writeln ('Valor repetido, digite outro');	
						end
					else 
						begin
								v[i]:= n;
								i:= i + 1;
						end;	
		  end;
		for i:=1 to n do 
			writeln (v[i], ' ');		
End.