Program Triangulo;
  Var Base, Altura, Area:Real;

Begin
    Write ('Informe a base do triângulo: ');
    Readln (Base);
    Write ('Informe a altura do triângulo: ');
    Readln (Altura);
    Area:= Base*Altura/2;
    Writeln ('Area do Triângulo ',Area:6:2);
end.  
