Program ex_27 ;

 var a, b, c: integer;
 
 
 procedure verifica_raiz ( var x, y, z: integer);
 var x1, x2, delta: real;
 begin
 	  delta:= y*y - 4*x*z;
  if (delta < 0) or (x=0) then
    writeln ('Não existem raízes reais ou não é equação de 2º grau!')
  else 
		begin
    x1:= (-y + sqrt(delta))/(2*x);
    x2:= (-y - sqrt(delta))/(2*x);
    writeln ('Raízes: ',x1:5:2, '   ',x2:5:2)
    end;
 end;

Begin
   writeln ('Digite o valor para a: ');
   readln ( a );
   writeln ('Digite o valor para b: ');
   readln ( b );
   writeln ('Digite o valor para c: ');
   readln ( c );
   verifica_raiz ( a, b, c );
End.