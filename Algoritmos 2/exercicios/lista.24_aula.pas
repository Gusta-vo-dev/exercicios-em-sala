Program question_24 ;

	type
		vetor = array[1..5, 1..5] of integer;
		
	var vet: vetor;
			l, c, result: integer;
	
	function soma ( v: vetor): integer;
	var s: integer;
	begin
			for l:=1 to 5 do 
    		for c:=1 to 5 do
    			s:= s + v[l, c];
    	soma:= s;
	end;

Begin
    for l:=1 to 5 do 
    	for c:=1 to 5 do
			begin 
    		vet[l,c]:= random(15) + 1;
    		gotoxy (c*4, l+8);
    		writeln ( vet[l,c]);
    	end;
    writeln;
    writeln;
    writeln;
    result:= soma(vet);
    writeln ('A soma do vetor é: ', result); 
End.