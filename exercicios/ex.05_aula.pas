Program Ex05;
  var C,F:real;
  
Begin
  Write('Digite a temperatura em Celsius ');
  Readln (C);
  F:= 1.8*C + 32;
  Writeln('Em Fahrenheit = ',F:6:2);
End.