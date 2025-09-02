Program ex_05 ;

		var i, qntd: integer;
				n: array[1..10] of integer;

Begin
	 writeln ('Digite a quantidade de elementos do vetor ( MÁX = 10 )');
	 readln ( qntd );
	 i:= 1;
   while i<= 10 do
   begin                                              
   		writeln ('Ditige o ' ,i, 'º número do vetor!');          
   		readln (  n[i] );
   		i:= i + 1;
   end;
   for i:=1 to qntd do
   	   writeln ( n[i] );
End.