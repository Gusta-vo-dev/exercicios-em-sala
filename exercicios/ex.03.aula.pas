Program Triangulo;
  Var Base, Altura, Area:Real;

Begin
    Write ('Informe a base do tri�ngulo: ');
    Readln (Base);
    Write ('Informe a altura do tri�ngulo: ');
    Readln (Altura);
    Area:= Base*Altura/2;
    Writeln ('Area do Tri�ngulo ',Area:6:2);
end.  
