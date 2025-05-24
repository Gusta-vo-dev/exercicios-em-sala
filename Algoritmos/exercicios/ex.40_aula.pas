
program bruh;


 var i, posicao:integer;

 num:array[1..25] of integer;
 
begin 
	posicao:=1;
		
	For i:=1 to 50 do
	 begin
	  if (i mod 2 <> 0) and (posicao <= 25) then
	   begin
	    num[posicao] := i; 
	    posicao:=posicao+1
	   end;
	 end;
	for i:=1 to 25 do
	writeln(num[i]);
End.
