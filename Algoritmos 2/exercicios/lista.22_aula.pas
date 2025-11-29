Program lista_22 ;

 	var num, r: integer;
 	
 	function somatorio ( n: integer): integer;
 	var soma, i: integer;
	 	begin
	 			soma:= 0;
	 			for i:=1 to n do
					 soma:= soma + i;
				somatorio:= soma;
	 	end;

Begin
    write ('Digite um número inteiro e positivo: ');
    readln ( num );
    r:= somatorio( num );
    writeln ('O resultado do somatório do número digitado é: ', r);
End.