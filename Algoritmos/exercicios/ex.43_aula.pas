Program ex_43 ;
		const max = 50;
		var i: integer;
				vetor: array[1..max] of integer;

Begin
   for i:=1 to max do
   		begin
   			vetor[i]:= (i + 5 * i) mod (i + 1);
   			writeln ( vetor[i] );
   	  end;
End.