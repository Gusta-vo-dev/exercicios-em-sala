Program Ex_SE;
 
  var num:integer;

Begin
   writeln ('Informe um n�mero inteiro');
   readln(num);
   if num < 0 then
      writeln ('n�mero � negativo')
   else 
	    if num=0 then
        writeln ('n�mero � nulo')
      else          
        writeln ('n�mero � positivo');
   writeln ('* * Fim do programa * *')
End.