program ex_35 ;

		var numero, i:integer;

Begin
  	writeln ('Digite um número inteiro');
  	readln ( numero );
    WriteLn('Divisores de ', numero, ':');
    for i := 1 to numero do
     begin
       if (numero mod i = 0) then
         WriteLn(i);
     end;
End.