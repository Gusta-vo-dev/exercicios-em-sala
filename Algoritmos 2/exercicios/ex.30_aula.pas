Program ex_30 ;

var n: integer;

  procedure calcula_tabu ( var num : integer);
  var i: integer;
	begin
	   for i:=1 to num do
	   begin
  			writeln ('   ', i, ' x ', n, ' = ', n*i);
		 end; 
  end;


Begin
   write('Escreva um número para calcular a tabuada: ');
   readln ( n );
   calcula_tabu ( n );
End.