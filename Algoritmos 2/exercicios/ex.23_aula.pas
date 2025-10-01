Program ex_23 ;

const max = 5;

type
	lojas = record
		nome: string[30];
		tel: integer;
		preco: real;
	end;

	media_lojas = array [1..max] of lojas;
	
	var media: media_lojas;
			m: real;
			i, abaixo: integer;	       	
		
Begin
    for i:=1 to max do
    begin
    	write ('Informe o nome da loja ', i ,':');
    	readln (media[i].nome);
    	write ('Informe o telefone da loja: ');
    	readln ( media[i].tel);
    	write ('Informe o pre�o de um eletrodom�stico da loja: ');
    	readln ( media[i].preco);
    	m:= m + media[i].preco;
    end;
    m:= m/5;
    writeln;
    writeln;
    writeln ('A m�dia dos pre�os das lojas informadas �: ', m );
    writeln;
    writeln;
    for i:=1 to max do
    	if m > media[i].preco then
    		writeln ('O pre�o da ', media[i].nome, '(',media[i].tel,') est� abaixo da m�dia!');
End.