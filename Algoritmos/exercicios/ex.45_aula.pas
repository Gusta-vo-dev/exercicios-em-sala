Program ex_45;

  var N,cont:integer; 
      a:real;

Begin
  a:=1;
  write ('Informe o número ');
  readln (N);
  for cont:= 1 to 20 do
  begin
    a:= (a+N/a)/2;
    writeln ('A = ',a:4:8);  
  end;
End.