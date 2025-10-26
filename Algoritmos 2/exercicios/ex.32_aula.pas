Program ex_32 ;
	
var n, i, j, prog, resultado: integer;		
	
	procedure fatorial ( var num: integer; var result: integer); 
	begin
		result:= 1;
	  for i:=1 to num do
			result:= result * (i * num);
	end;
	
Begin
	write ('Digite um número para fatorar: '); 
	readln ( n );
	write ('Você quer que o resultado seja feito escrito no programa principal ou no procedimento?(0- Programa Princial. 1- Procidimento)');
	readln ( prog );
	resultado:= 1;
	j:= n;
	if prog = 0 then
		begin
			for i:=1 to n do
				resultado:= resultado * j;
				
			writeln ('O resultado da fatoração é: ', resultado);
		end
	else 
		if prog = 1 then
			fatorial ( n, resultado );
End.