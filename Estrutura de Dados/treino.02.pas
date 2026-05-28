Program Pzim ;


 		//CORRIGIR ERROS NA LINHA 25 "o número de dimmensões para F está incorreto"//
 		//Para melhor entendimento, refazer procedimentos, funções, registros tudo novamente//



	const max = 3;
	type 
	  minhafila = record
		 	Tfila: array [1..max] of integer;
		 	inicio, fim: integer;
		end; 
		 
	var fila: minhafila;
	
	procedure inicializar( var f: minhafila);
	begin
		 f.inicio:= 1;
		 f.fim:= 0;
	end;
	
	procedure inserir( var f: minhafila);
	begin
		 if f.fim < max then
		 begin
		 		f.fim:= f.fim + 1;
		 		writeln;
		 		write('Digite o ', f.fim, '° número da fila: ');
		 		readln ( f[f.fim] );
		 end;
	end;
	
	function vazia ( var f: minhafila): boolean;
	begin
		 vazia:= f.inicio > f.fim;
	end;
	
	procedure remover ( var f: minhafila );
	begin
		if vazia(f) then
				writeln ('A fila está vazia')
		else
				writeln('A fila está cheia');
	end;
	
Begin
   inicializar( inicio, fim );
   inserir( fila, fim );
   inserir( fila, fim );
   inserir( fila, fim );
   remover ( fila );
   writeln;
   writeln ('   ASSIM FICOU A SUA FILA APÓS A INSERÇÃO DE ITENS');
   writeln ('   -----------------------------------------------');
   for i:=1 to max do
   	write ( ' | ', fila[i]);
   writeln;
End.