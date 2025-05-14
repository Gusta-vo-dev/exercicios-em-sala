Program ex_22 ;

	var impar:integer;

Begin
		impar:= 1;
    while impar<=100 do 
    	begin
			 if (impar mod 2) <> 0 then
			 	write ( impar, ' ');
			 impar:= impar + 2;
			end;    	   	
End.