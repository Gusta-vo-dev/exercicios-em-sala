Program ex_25 ;

		var ante, num, i:integer;

Begin
     writeln ('Digite um número');
     readln (num);
     writeln ('Os 10 números antessessores são :');
		 for i:= 1 to 10 do
      begin
       ante:= num - i;
     	 writeln (ante);
      end;
End.