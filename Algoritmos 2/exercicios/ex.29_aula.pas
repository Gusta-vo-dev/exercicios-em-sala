Program ex_29 ;

 var num, resultado: integer;
 
 
 //Procedimento para Verificar se é par ou ímpar//
 procedure verifica_num ( var numero: integer; var result: integer);
 var a: integer;
 begin
 	  a:= numero div 2;
 	  if a*2 = numero then
 	  	result:= 0
 	  else 
 	  	result:= 1;
 end;

Begin
   writeln ('Digite um número');
   readln ( num );
   verifica_num ( num, resultado );
	   if resultado = 0 then 
	   		writeln ('O número ', num, ' é par!')
	   else 
	   		writeln ('O número ', num, ' é ímpar!');
End.