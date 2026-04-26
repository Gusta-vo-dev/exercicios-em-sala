Program Pzim ;

	const max = 3;
	
	type Tfila = array[1..max] of integer;

	var inicio, fim, i, remover: integer;
			fila: Tfila;
	
	//Procedimento para melhorar a remoção de itens da fila//		
	procedure remove_fila ( f: Tfila; final: integer; var inic: integer);
		begin
		 if final >= inic then
				 inic:= inic + 1
		 else 
		 		 writeln('A fila está vazia!');
		 writeln;
	   writeln ('   ASSIM FICOU A SUA FILA APÓS A REMOÇÃO DO ITEM');
	   writeln ('   -----------------------------------------------');
	   for i:= inic to final do
				 begin                   
			   		write ( ' | ', f[inic]);
			   		inic:= inic + 1;
			   end;
	   writeln;
		end;
			
Begin
	 //iniciando fila//
   inicio:= 1;
   fim:= 0;
   
   //inserindo itens na fila//
   if fim < max then
   begin
   		fim:= fim + 1;
   		write ('Insira o primeiro item da fila: ');
   		readln ( fila[fim]);
   end;
   
   if fim < max then
   begin
   		fim:= fim + 1;
   		write ('Insira o segundo item da fila: ');
   		readln ( fila[fim]);
   end;
   
   if fim < max then
   begin
   		fim:= fim + 1;
   		write ('Insira o terceiro item da fila: ');
   		readln ( fila[fim]);
   end;
   
   
   //Escrevendo como ficou a fila cheia//																																											
   writeln;   
   writeln;
   writeln ('   ASSIM FICOU A SUA FILA APÓS A INSERÇÃO DE ITENS');
   writeln ('   -----------------------------------------------');
   for i:=1 to max do
   	write ( ' | ', fila[i]);
   writeln;
   remove_fila( fila, fim, inicio );
End.