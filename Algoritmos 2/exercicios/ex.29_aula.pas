Program ex_29 ;

 var num, resultado: integer;
 
 
 //Procedimento para Verificar se � par ou �mpar//
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
   writeln ('Digite um n�mero');
   readln ( num );
   verifica_num ( num, resultado );
	   if resultado = 0 then 
	   		writeln ('O n�mero ', num, ' � par!')
	   else 
	   		writeln ('O n�mero ', num, ' � �mpar!');
End.