Program ex_34 ;

var n1, n2: integer;

procedure troca ( var num1, num2: integer);
	  var v: array [1..2] of integer;
	  		i: integer;
		begin
				v[1]:= num1;
				v[2]:= num2;
				writeln ('O valor de n1 passou a ser: ', v[2]);
				writeln ('O valor de n2 passou a ser: ', v[1]);
		end;
Begin
   write ('Digite o valor de n1: ');
   readln ( n1 );
   write ('Digite o valor de n2: ');
   readln ( n2 );
   troca ( n1, n2);
End.