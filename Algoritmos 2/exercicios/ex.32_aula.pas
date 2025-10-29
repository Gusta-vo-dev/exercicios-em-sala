Program ex_32 ;
	
var n, prog, resultado: integer;		
	
	procedure fatorial ( var num: integer; var result: integer; var programa:integer); 
	var i: integer;
	begin
		result:= 1;
	  for i:=1 to num do
			result:= result * i;
		if programa = 1 then
			writeln ('O resultado da fatoração é: ', resultado);
	end;
	
Begin
	write ('Digite um número para fatorar: '); 
	readln ( n );
	write ('Você quer que o resultado seja feito escrito no programa principal ou no procedimento?(0- Programa Princial. 1- Procidimento)');
	readln ( prog );
	if prog = 0 then
	begin
		fatorial( n, resultado, prog );
		writeln ('O resultado da fatoração é: ', resultado);
	end
	else if (prog = 1) then
				fatorial ( n, resultado, prog );
End.