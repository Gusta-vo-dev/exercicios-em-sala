
program ex_41;

 var i, escalar:integer;

vetor1:array[1..10] of integer;
vetor2:array[1..10] of integer;
vetor3:array[1..10] of integer ;

begin
 for i:=1 to 10 do 
 begin
  writeln('Valor',i, 'vetor 1');
  readln(vetor1[i]) ;
  writeln('Valor',i, 'vetor 2');
  readln(vetor2[i]);
  vetor3[i]:=vetor2[i]*vetor1[i];
  writeln(vetor3[i])
 end;
 for i:=1 to 10 do
  escalar:=escalar+vetor3[i];
  writeln(escalar);
end.   
 
