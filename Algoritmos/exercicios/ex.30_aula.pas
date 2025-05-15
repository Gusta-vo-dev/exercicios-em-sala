Program Ex_30;

  var s,cont,n,qtde:integer;
      
Begin
   cont:=1;
   s:=0;
   qtde:=0;
	 while cont<=10 do
	   begin
	      write ('Informe um valor ',cont,' ');
        readln (n);
	      s:=s + n;
	      if (n>10) and (n<50) then
	         qtde:=qtde+1;
	      cont:=cont+1;	      
	   end;
	   writeln ('Média dos valores = ',(s/10):6:2);
     writeln ('Qtde de números no intervalo = ', qtde)  
End.