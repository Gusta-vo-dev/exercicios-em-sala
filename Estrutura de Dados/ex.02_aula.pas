Program ex_3 ;
		 const max = 5;
		 type 
		 	 mypilha = array[1..max] of integer;
		 	 
		 
		 var inicio, fim, i: integer;
		 		 pilha: mypilha;
		 		 
		 
		 procedure iniciar (p: mypilha);
		 begin
		 		inicio:= 1;
		 		fim:= 0 ;
		 end; 
																																								
Begin
   writeln ( iniciar( pilha ));
End.