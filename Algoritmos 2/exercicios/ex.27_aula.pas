Program Alg27;
  var a,b,c,x1,x2: real;
      erro:integer;
      
procedure baskara (A1, B1, C1:real; var R1,R2:real; var erro_delta:integer);
  
  var delta:real;

begin
  erro_delta:=0;
  if A1 = 0 then
    erro_delta:=2
  else begin
		delta:=B1*B1 - 4*A1*C1;
		if delta<0 then
		   erro_delta:=1
		else 
		  begin
		    R1:= (-B1 + Sqrt(delta))/(2*A1);
		    R2:= (-B1 - Sqrt(delta))/(2*A1);
		  end
  end
end;      
      
//Prog. PRINCIPAL      
Begin
  writeln ('Informe os coeficientes da equa��o de segundo graus');
	readln( A, B, C);
	
	// leva os coeficientes e retornam as ra�zes e valor do erro caso delta seja negativo	

  baskara(A, B, C, X1, X2, Erro);
  if erro = 1 then
     writeln ('N�o h� ra�zes reais para a equa��o')
  else if erro = 2 then
     writeln ('Valores n�o correspondem a equa��o 2o grau')  
  else begin
     writeln ('Raiz 1 = ',X1:6:2);
     writeln ('Raiz 2 = ',X2:6:2);
  end
End.