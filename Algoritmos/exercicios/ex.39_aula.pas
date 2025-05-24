Program ex_39 ;

	const cont=5;
	var i: integer;
			soma:real;
			num: array[1..cont] of integer;

Begin
    for i:= 1 to cont do
    		begin
    			writeln ('Digite um o valor ', i);
    			readln (num[i]);
    			soma:=soma+num[i];
    		end;
    writeln ('A media dos 5 valores são ', soma/5);
End.