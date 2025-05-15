Program ex_31 ;

	var chicoalt, zealt: real;
			anos: integer;

Begin
		chicoalt:= 1.50;
		zealt:= 1.10;
		anos:= 0;  
		while  chicoalt > zealt do 
	 		begin
	 			chicoalt:= chicoalt + 0.02;
	 			zealt:= zealt + 0.03;
	 			anos:= anos + 1;
	 		end;
		writeln ('Zé demorou ', anos, ' anos para ficar maior que o Chico e ficou com ', zealt ,' metros de altura.');
End.