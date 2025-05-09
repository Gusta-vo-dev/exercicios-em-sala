Program ex_24 ;

 var num, cont: integer;

Begin
   writeln ('Digite um valor');
   readln(num);
   cont:=1;
   while 1<num do
   	begin
   		write (num + cont, ' ');
   		cont:= cont + 1;
   	end;
End.