Program ex_09 ;

	var l, c, x, achou:integer;
			a: array[1..3,1..3] of integer;

Begin
		 write ('Digite o Valor que voc� quer encontrar na matriz');
	   read ( x );
		 achou:= 0;
     for l:=1 to 3 do
     		for c:=1 to 3 do
					a[l, c]:= random(10);
     	//verificando se o valor est� na matriz
     for l:=1 to 3 do
     begin
     	for c:=1 to 3 do
     		begin
     			if a[l, c] = x then
     				achou:= 1;
     				write ( a[l,c]:4);
     		end;
     end;
   writeln; 
	 if achou = 1 then
	 		writeln ('N�mero ', x, ' est� na matriz')
	 		
	 else 
	 		writeln('N�mero ', x, ' n�o est� na matriz');			
End.