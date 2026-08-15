Program tabela_hash ;
	
	uses crt;
	
	type
		ponteiro = ^elemento;
		elemento = record
			dado: string;
			prox: ponteiro;
		end;
		
		tabela_hash = array[0..99] of ^elemento;
	
  var  cpf:  string;
       tabela: tabela_hash;
       op: byte;
       
  procedure iniciar_tabelas ( var tab: tabela_hash );
  var i: integer;
  begin
  	for i:=0 to 99 do
			tab[i]:= nil;	
  end;
  
  function ler_cpf ( var iCpf: string ): string;
  begin
  	write (' Digite o CPF: ');
  	readln ( iCpf );
		ler_cpf:= iCpf;
  end;
  
  function limpa_cpf ( var texto: string ): string; // Limpa à máscara do CPF //
  var limpo: string;
      i: integer;
  begin
  	 limpo:= '';
  	 for i:=1 to length(texto) do
  	 	if ( texto[i] >= '0' ) and ( texto[i] <= '9' ) then
  	 		limpo:= limpo + texto[i];
  	 limpa_cpf:= limpo;
  end;
  
  function valida_primeiro_digito_verificador ( cpf: string ): integer; // Cálculo/válida do primeiro dígito verificador //
  var i, resto, soma, d1:integer;
  begin
  	 soma := 0;  
			for i := 1 to 9 do
			  soma := soma + (ord(cpf[i]) - 48) * (11 - i); 
			resto := soma mod 11;
			if resto < 2 then 
			  d1 := 0
			else 
			  d1 := 11 - resto;
			valida_primeiro_digito_verificador:= d1;  
  end;
  
  
  function valida_segundo_digito_verificador ( cpf: string ): integer; // Cálculo/válida do segundo dígito verificador // 
  var i, resto, soma, d2:integer;
  begin
  	 soma := 0;
			for i := 1 to 10 do
			  soma := soma + (ord(cpf[i]) - 48) * (12 - i);  
			resto := soma mod 11;
			if resto < 2 then 
			  d2 := 0
			else 
			  d2 := 11 - resto;
			valida_segundo_digito_verificador:= d2;
  end;
  
  function valida_cpf ( var iCpf: string ): boolean; // Função que retorna se o CPF é válido ou não //
  var valido: boolean;
      i: integer;
  begin
     iCpf:= limpa_cpf( iCpf ); // Chama a função limpa_cpf para usar o CPF sem caracter especial //
     valido:= false;
    
		 if length(iCpf) <> 11 then
		  	 valido:= false
		 else
		 begin
		 	for i:=2 to 11 do // verifica se não são todos iguais //
      	 if iCpf[i] <> iCpf[1] then
			 			valido:= true;
			if valido = true then // Se a condição for verdadeira, irá validar os digitos verificadores //
			begin
			  if ((ord(iCpf[10]) - 48) = valida_primeiro_digito_verificador ( iCpf )) and ((ord(iCpf[11]) - 48) = valida_segundo_digito_verificador ( iCpf )) then  // Verifica os dígitos cálculado com os originas
			    valida_cpf:= true
			  else
			    valida_cpf := false; 
			end
			else
				valida_cpf:= false;
		end;
	end;
	
	function funcaoHash(icpf: string): integer; // Cálcula o indice de cada CPF para inserir na tabela hash //
	var d1, d2: integer;
	begin
	  d1 := Ord(iCpf[10]) - Ord('0');
	  d2 := Ord(iCpf[11]) - Ord('0');
	  funcaoHash := (d1 * 10) + d2;
	end;
	
	function verifica_se_existe ( var tab:tabela_hash; var iCpf: string): boolean; // Função booleana que verifica se o CPF já foi inserido ou não na tabela //
  var aux: ponteiro;                                                                           
      indice: integer;
  begin
  	 indice:= funcaoHash( iCpf ); // Chama funcaoHash para percorrer apenas a lista encadeada em que pode estar inserido o CPF //
  	 aux:= tab[indice];
  	 while (aux <> nil ) and (aux^.dado <> iCpf) do
  	  	aux:= aux^.prox;
  	 if aux = nil then
  	 	 verifica_se_existe:= false // Retorna falso caso o CPF não esteja inserido ainda //
  	 else 
  	 	 verifica_se_existe:= true  // Retorna verdadeiro caso o CPF esteja inserido //
  end; 
	
	procedure insere_tabela_hash ( var tab: tabela_hash; iCpf: string); // Insere CPF na tabela hash //
	var aux, atual: ponteiro;
			i, indice: integer;
	begin
		 indice:= funcaoHash ( iCpf );
		 new( aux );
		 aux^.dado:= iCpf;
		 aux^.prox:= nil;
		 if tab[indice] = nil then // Se o vetor na posição do índice estiver vázio, ele insere aqui //
		 begin
		 		tab[indice]:= aux;
		 		writeln (' O CPF digitado foi inserido no índice: ', indice,' da tabela!');
		 end
		 else // Se não estiver vázio, insere como último item da lista encadeada simples //
		 begin
		 		atual:= tab[indice];
		 		while atual^.prox <> nil do
		 			atual:= atual^.prox;
		 		atual^.prox:= aux;
		 		writeln (' O CPF digitado foi inserido no índice: ', indice,' da tabela!');
		 end;
	end;
	
  procedure proc_principal ( var tab: tabela_hash );// Procedimento principal de inserção de CPF's //
  var cpf: string;
  begin
  	 ler_cpf ( cpf );
  	 if (valida_cpf ( cpf ) = true) then // Se o CPF for válido, ele é inserido na tabela hash //
  	   if (verifica_se_existe( tab, cpf ) = false ) then
			 	 insere_tabela_hash ( tab, cpf )
			 else
			 	 writeln (' O CPF digitado já está inserido na tabela!')
  	 else
  	 begin
  	   writeln;
  	   writeln (' CPF digitado é inválido! ');
  	 end;
  end;
  
  procedure consulta_cpf ( var tab: tabela_hash); // Consulta um CPF específico da tabela hash //
  var aux: ponteiro;
      cpf: string;
      indice: integer;
  begin
    ler_cpf ( cpf );
  	if valida_cpf ( cpf ) = true then // Válida o CPF digitado antes de tentar consulta-lo //
		begin 
	  	indice:= funcaoHash( cpf );
	  	aux := tab[indice];
			while (aux <> nil ) and (aux^.dado <> cpf) do
			  aux:= aux^.prox;
			if aux = nil then // Caso tenha percorrido a lista encadeada e não encontrado o CPF digitado para consulta //
				writeln (' O CPF digitado não está na lista!') 
			else 
				writeln(' CPF encontrado na tabela no índice: ', indice);
		end
		else
			writeln (' CPF digitado é inválido! '); 	
  end;
	
	procedure imprimir_tabela( var tab: tabela_hash);
	var i: integer;
	    atual: ponteiro;
	begin
	  writeln;
	  writeln(' ================ CONTEÚDO DA TABELA HASH ================');
	  writeln;
	  for i := 0 to 99 do
  	begin
    if tab[i] <> nil then
    begin
      write(' Índice ', i:2, ' -> ');
      atual := tab[i];
      while atual <> nil do
      begin
        write(atual^.dado);
        if atual^.prox <> nil then
          write('  ->  ');
        atual := atual^.prox;
      end;
      writeln;
    end
    else 
    begin
    		write(' Índice ', i:2, ' -> ');
    		writeln('NIL');
    end;
  end;
	  writeln('===========================================================');
	end;

		
Begin
  iniciar_tabelas ( tabela );
  while true do
  begin
	  writeln(' 0 - Encerrar Programa');
	  writeln(' 1 - Inserir CPF na Tabela');
	  writeln(' 2 - Remover CPF da tabela');
	  writeln(' 3 - Verifica se CPF é Válido');
	  writeln(' 4 - Consultar CPF na Tabela');
	  writeln(' 5 - Escreve toda a tabela');
	  repeat
	    writeln;
	    write (' Escolha uma opção: ');
	    readln ( op );
	    writeln;
	  until ( op in [0..5]);
	  case op of
	    0: halt;
	  	1: proc_principal( tabela );
	  	2: remove_cpf_da_tabela;
	  	3: begin
				 	ler_cpf ( cpf );
				 	if valida_cpf( cpf ) = true then
				 		writeln (' O CPF digitado é válido!')
				  else
				  	writeln (' O CPF digitado não é válido!');
				 end;
	  	4: consulta_cpf ( tabela );
			5: imprimir_tabela ( tabela );
	  end;
	  writeln;
	  write(' Clique em qualquer tecla para prosseguir...'); 
	  readkey;
	  clrscr;
	end;	
End.