Program ex_05 ;

		var i, j, num: integer;
			  vetor: array[1..10] of integer;
				achou: boolean;

Begin
		  for i := 1 to 10 do
  begin
    repeat
      achou := False;
      Write('Digite o ', i, '� n�mero: ');
      ReadLn(num);

      // Verifica se o n�mero j� foi inserido
      for j := 1 to i - 1 do
      begin
        if vetor[j] = num then
        begin
          achou := True;
          WriteLn('N�mero j� inserido. Digite outro valor.');
          Break;
        end;
      end;

      until not achou;

    vetor[i] := num;
  end;

  // Mostra o vetor final
  WriteLn('Vetor sem elementos repetidos:');
  for i := 1 to 10 do
    Write(vetor[i], ' ');
  WriteLn;
End.