Program question_10 ;

	const max = 5;

	type
		vet = array[1..max] of real;
	
	var i: integer;
			v: vet;
			result: real;
	
	function somando ( vetor: vet): real;
	var s: real;
	begin
			for i:=1 to max do 
				 s:= s + vetor[i];
			somando:= s;
	end;

Begin
	 randomize;
   for i:=1 to max do 
   begin
   		write('Escreva o ', i,'º número do vetor: ');
   		readln ( v[i] );
   end;
   writeln;
   writeln;
   writeln;
   result:= somando( v );
   writeln ('A soma do vetor é: ', result:0:2); 
End.