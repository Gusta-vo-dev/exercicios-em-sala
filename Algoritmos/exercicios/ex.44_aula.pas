Program  ex_44;
  const qtde=6;
  var v, par, impar: array[1..qtde] of integer;
      i,cpar,cimp:integer;

begin
  cpar:=0;
  cimp:=0;
  For i:= 1 to qtde do
  begin
  	Write('Informe o ',i,'o. valor ');
    Readln (v[i]);
    if v[i] mod 2 =0 then
    begin 
       cpar:=cpar+1;
       par[cpar]:=v[i]
    end
    else begin
       cimp:=cimp+1;
       impar[cimp]:=v[i];
    end;      
  end;
  writeln('PARES');
  For i:= 1 to cpar do
     write (par[i],' ');
  writeln;
  writeln('IMPARES');
  For i:= 1 to cimp do
     write (impar[i],' ');
end.