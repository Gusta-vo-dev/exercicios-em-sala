Program ex_14 ;

		var maior, medio, menor, a, b, c, num:integer;

Begin
    writeln ('Digite três valores');
    readln (a, b, c);
    if (a > b) and (a > c) then
    begin
			maior:= a;
    	if (b > c) then 
    	begin
				medio:= b;
    		menor:= c
    	end
    	else
    	begin
    		medio:= c;
    		menor:= b;
    if ( b > a) and (b > c) then
    begin
			maior:= b;
    	if (a > c) then
    		medio:= a;
    		menor:= c;
    end
    else
    begin
    		medio:= c;
    		menor:= a
    end
    else if (c > a, b) then
   	maior:= c;
   	if ( a > b ) the
End.