Program lista_21 ;

 	var num, r: integer;
 	
 	function acha_divisores( n: integer):integer;
 	var cont, i: integer;
 	begin
 			cont:= 0;
 			for i:=1 to (n div 2) do
 			begin
 					if n mod i = 0 then
 						cont:= cont + 1;
 			end;
 			cont:= cont + 1;
 			acha_divisores:= cont;
 	end;
 	
Begin
   write ('Digite um número inteiro e positivo para acharmos seus divisores: ');
   readln ( num );
   r:= acha_divisores(num);
   writeln;
   writeln ('O número ', num, ' tem ', r, ' divisores!');
End.