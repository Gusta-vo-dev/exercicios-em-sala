Program ex_25 ;

		var ante, num, i:integer;

Begin
     writeln ('Digite um n�mero');
     readln (num);
     writeln ('Os 10 n�meros antessessores s�o :');
		 for i:= 1 to 10 do
      begin
       ante:= num - i;
     	 writeln (ante);
      end;
End.