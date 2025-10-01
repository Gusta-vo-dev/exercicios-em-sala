Program Exemplo_registro;

type
  reg_aluno = record
    codigo:integer;
		Nome:String[40];
		N1:real;
		N2:real;
		N3:real;
		Media:real;
	end;
	
	vet_aluno = array[1..30] of reg_aluno;

var 
  aluno:vet_aluno;
  N, I:integer;

Begin
  write ('Informe qtdade de alunos: ');
	readln (N);
	for i:= 1 to N do
	  with aluno[i] do
		begin
      write ('Informe código do aluno: ');
	    readln (codigo);
      write ('Informe nome do aluno: ');
	    readln (nome);
      write ('Informe 3 notas do aluno: ');
	    readln (n1,n2,n3);
      media:=(n1+n2+n3)/3;
		end;		 
	clrscr;
  writeln ('Dados Cadastrados ');
  writeln ('Cód. Nome                                      N1    N2    N3    Média');
	writeln;
	for i:= 1 to N do
	  with aluno[i] do
		begin
	    write (codigo:5);
	    write (nome:40);
	    write (n1:6:2,n2:6:2,n3:6:2);
      writeln(media:6:2);
		end;		 
End.