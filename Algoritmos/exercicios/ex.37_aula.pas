Program Ex_37;
  const qtde=20;
  var i,popmaior:integer;
      media:real;
      pop: array[1..qtde] of integer;
      
Begin
  For i:= 1 to qtde do
  begin
  	Writeln('Informe a popula��o do munic�pio ', i);
    Readln (pop[i]);
    media:=media + pop[i];
  end;
  media:=media/qtde;
  For i:= 1 to qtde do
    if pop[i] > media then  
		  popmaior:=popmaior+1;		  
	writeln ('A 5
	quantidade de munic�pios com popula��o maior que a m�dia ',popmaior)
End.
