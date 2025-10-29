Program ex_35 ;

var frase: string[50];

procedure tira_espacos (var f: string[50]);
	var i: integer;
			result: string[50];
	begin
		 for i:=1 to length(f) do 
		 	if f[i] <> ' ' then 
		 	begin
		 		 result:= result + f[i];
		 	end;
		 writeln;
		 writeln;
		 writeln ('    A palavra original é: ',  f);
		 writeln; 
		 writeln ('    A palavra sem espaços em branco é: ', result);	
	end;


Begin
   write ('    Escreva uma frase: ');
   readln (    frase );
   tira_espacos(frase);
End.