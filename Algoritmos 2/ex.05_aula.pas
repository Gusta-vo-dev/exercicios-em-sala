Program ex_05;

<<<<<<< HEAD
		var i, j, qntd: integer;
				n: array[1..10] of integer;
				achou: boolean;

Begin
	 writeln ('Digite a quantidade de elementos do vetor ( MÁX = 10 )');
	 readln ( qntd );
	 i:= 1; 
	 achou:= false;     
   while i<= qntd do
   begin                                              
   		writeln ('Ditige o ' ,i, 'º número do vetor!');          
   		readln (  n[i] );
   		j:=2;
   		while j<= qntd do3
   		begin 
   				if n[i] = n[j-1] then
   						writeln ('Número repetido, digiti-o novamente!');
   						achou:= true;
   						break;
   		end;
   		i:= i + 1;
   end;
=======
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
						end;
				 i:= i + 1;			
		  end;
		for i:=1 to n do 
			writeln (v[i], ' ');		
>>>>>>> 7f902a6764fb52be226a22989b45c36abe80f7fa
End.