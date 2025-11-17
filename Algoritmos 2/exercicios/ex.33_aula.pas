<<<<<<< HEAD
Program ex_33 ;

var n: integer;

procedure matriz (var num: integer);
	var l, c, j: integer;
	begin
		j:= 1;
		for l:=1 to num do
			for c:=1 to num do
			begin
				 gotoxy (c*8, l+4);
				 if l = c then
				 begin 
				 	 writeln ( j );
				 	 j:= j + 1;
				 end                           
				 else if ( l <> c) and ( c <> 1) and ( c <> num ) and ( l <> num) and ( l <> 1) then
				 	 writeln ( ' ' )
				 else
				 	 writeln ( '*' );
			end;
	end;
Begin                                     
   write ('Digite um número para a Linha e Coluna: ');
	 readln ( n );
	 matriz ( n );
=======
Program ex_33;

	var raio, result:real;
	
	function calcula_raio ( var r:real) : real;
	begin
		 calcula_raio:= 4/3 * (3.14 * r * r * r);
	end;

Begin
   write ('Digite o raio: ');
   readln ( raio );
   result:= calcula_raio(raio);
	 writeln (result); 
>>>>>>> 1aedc71892f21f2be413293b5fbab121cbceb84f
End.