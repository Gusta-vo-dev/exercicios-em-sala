Program ex_05 ;

		var i, j, qntd: integer;
				n: array[1..10] of integer;
				achou: boolean;

Begin
	 writeln ('Digite a quantidade de elementos do vetor ( M�X = 10 )');
	 readln ( qntd );
	 i:= 1; 
	 achou:= false;     
   while i<= qntd do
   begin                                              
   		writeln ('Ditige o ' ,i, '� n�mero do vetor!');          
   		readln (  n[i] );
   		j:=2;
   		while j<= qntd do3
   		begin 
   				if n[i] = n[j-1] then
   						writeln ('N�mero repetido, digiti-o novamente!');
   						achou:= true;
   						break;
   		end;
   		i:= i + 1;
   end;
End.