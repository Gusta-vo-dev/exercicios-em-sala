Program ex_31;

	var palavra: string[30];
	
	procedure achar_vogais (var vogais: string[30]);
	var letras: array[1..30] of char;
			i, cont:integer;
	begin
		cont:= 0;
		for i:=1 to length(vogais) do
		begin
			letras[i]:= vogais[i];
			if (letras[i] = 'a') or (letras[i] = 'e') or (letras[i] = 'i') or (letras[i] = 'o') or (letras[i] = 'u') then
					cont:= cont + 1;
		end;
		writeln ('A palavra digitada tem : ', cont, ' vogais!');
	end;
Begin
   write ('Digite uma palavra: ');
   readln ( palavra );
   achar_vogais(palavra);
End.