Program ex_28 ;

 var num: integer;
 
 
 //Procedimento para Verificar se � par ou �mpar//
 procedure verifica_num ( var numero: integer);
 var a: integer;
 begin
 	  a:= numero div 2;
 	  if a*2 = numero then
 	  	writeln ('O n�mero ', numero, ' � par!')
 	  else 
 	  	writeln ('O n�mero ', numero, ' � �mpar!');
 end;

Begin
   writeln ('Digite um n�mero');
   readln ( num );
   verifica_num ( num );
End.