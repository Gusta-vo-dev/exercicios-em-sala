Program lista_23 ;

	var num: integer;
			r: real;
	
	function valor_s ( n: integer): real;
	var n2: integer;
			s: real;
	begin
			s:= 1;
			n2:= 2;
	    while n2 <= n do
	    begin
	    		s:= s + (1 / 2);
	    		n2:= n2 + 1;
	    end;
	    valor_s:= s;
	end;
	
Begin
    write ('Digite um número inteiro e positivo: ');
    readln ( num );
    r:= valor_s(num);
    writeln ('O valor de S é: ', r:0:2);
End.