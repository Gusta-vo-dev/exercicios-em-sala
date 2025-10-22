Program ex_28 ;

 var num: integer;
 
 
 //Procedimento para Verificar se é par ou ímpar//
 procedure verifica_num ( var numero: integer);
 var a: integer;
 begin
 	  a:= numero div 2;
 	  if a*2 = numero then
 	  	writeln ('O número ', numero, ' é par!')
 	  else 
 	  	writeln ('O número ', numero, ' é ímpar!');
 end;

Begin
   writeln ('Digite um número');
   readln ( num );
   verifica_num ( num );
End.