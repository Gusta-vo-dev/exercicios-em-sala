Program ex_26 ;

		var mult4:integer;

Begin
    mult4:= 1;
    while (mult4<=500) do
     begin
       if mult4 mod 4 = 0  then
        write (mult4, ' ');
       mult4:= mult4 + 4;
     end;               
End.