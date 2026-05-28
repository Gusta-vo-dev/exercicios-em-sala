Program lista_encadeada_dupla ;

	type princ = string;
	   ptnodo = ^elemento;
	   elemento = record
	     dado: princ;
	     prox: ptnodo;
	   end;
	
	var lista: ptnodo;
			num: princ;
			op: byte;
	
	procedure criarLista ( list: ptnodo );
	begin
		list:= nil;
	end;
	
	procedure leitura( n: princ );
	begin
			write ('Digite um número: ');
			readln ( n );
	end;
	
	procedure inserir ( n: princ; list: ptnodo );
	var aux: ptnodo;
	begin
	   aux(new);
	   if aux = nil the
	   begin
	   		writeln ('Sua lista encadeada está cheia');
	   		readkey;
	   end
	   else
	   begin
	   		aux^.dado:= n;
	   		aux^.prox:= list;
	   		list:= aux;
	   end;
	end;
	
	procedure 
			

Begin
  
End.