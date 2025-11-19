Program desafio_02 ;

		type 
			 vetor = array[1..10] of integer;
			 
	  var vet_a: vetor;
				vet_b: vetor;
				i, tam_a, tam_b: integer;
				
		procedure ler_vetor (var vet: vetor);
		var tam: integer;
		begin
			writeln ('Qual o tamanho do vetor?( MAX = 10');
			readln( tam );
		 	for i:=1 to tam do
		 	begin
		 		write('Digite o índice ', i,' do vetor: ');
		 		readln (vet[i]);
		 	end;
		end;
Begin
	ler_vetor(vet_a,tam_a);
	ler_vetor(vet_b, tam_b);
End.