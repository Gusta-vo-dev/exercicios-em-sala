Program ex_01;

		var i, soma, cm: integer; 
				media: real;
		    num: array[1..10] of integer;
Begin
    for i:=1 to 10 do
      begin 
    			writeln ('Escreva um n�mero inteiro');
					readln (num[i]);
						if num[i] > 0 then
            	begin
								soma:= soma + num[i];
								cm:= cm + 1;
							end;
		  end;                  
	  media:= soma div cm;
	  writeln ('A m�dia dos n�meros positivos �: ', media, '.');
End.