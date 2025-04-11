Program Ex_SE;
 
  var num:integer;

Begin
   writeln ('Informe um número inteiro');
   readln(num);
   if num < 0 then
      writeln ('número é negativo')
   else 
	    if num=0 then
        writeln ('número é nulo')
      else          
        writeln ('número é positivo');
   writeln ('* * Fim do programa * *')
End.