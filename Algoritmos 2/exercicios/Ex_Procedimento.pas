Program Exemplo_Procedimentos;



type vetor = array[1..5] of integer;

var a, b:vetor;
		tam_a, tam_b: integer;




//Procedimento para ler vetor
procedure ler_vetor (var v:vetor; tam: integer);
var i:integer;

begin
  for i:=1 to tam do
  readln (v[i]);
end;

//Procedimento para escrever vetor
procedure escreve_vetor (v:vetor; tam:integer);
var i:integer;




begin
  for i:=1 to tam do
  write (v[i], ' ');
end;




//Programa Principal
Begin
	writeln ('Informe o tamanho do vetor A e B');
	readln (tam_a, tam_b);
  ler_vetor(a,tam_a);
  ler_vetor(b,tam_b);
  escreve_vetor (a,tam_a);
  escreve_vetor (b,tam_b);
End.