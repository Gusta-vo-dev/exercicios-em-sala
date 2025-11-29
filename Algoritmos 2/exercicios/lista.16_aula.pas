Program Ex_online ;

	type 
		pesquisa_hab = record
				salario: real;
				filhos: integer;
	  end;
	  vetor = array [1..50] of pesquisa_hab;
	  
	  var vet: vetor;
				i, tam: integer;
	  
		procedure calc_pesquisa ( v: vetor; var n: integer );
		var media_sal, media_fil, maior: real;
				cont: integer;
		begin
			 cont:= 0;
			 media_sal:= 0;
			 media_fil:= 0;
			 for i:=1 to n do
			 with v[i] do 
			 begin
			 		media_sal:= media_sal + salario;
			 		media_fil:= media_fil + filhos;
			 		if salario <= 350 then
			 				cont:= cont + 1;
			 end;
		   media_sal:= media_sal / n;
		   media_fil:= media_fil / n;
			 writeln ('A média salarial da população pesquisada é: ', media_sal:0:2);
			 writeln;
			 writeln ('A média de filhos por casal da poppulação é: ', media_fil:0:2);
			 writeln;
			 writeln ('A quantidade de casais que ganham um salário inferior há R$350 é: ', cont:0:2); 	
		end;
				
Begin
    writeln ('Quantos casais você vai entrevitar?');
    readln ( tam);
    for i:=1 to tam do 
    with vet[i] do
    begin
    		writeln ('Qual é o salário da ', i,'ª família?');
				readln ( salario );
				writeln ('Quantos filhos o casal tem?');
				readln ( filhos ); 
    end;
    calc_pesquisa ( vet, tam);
End.