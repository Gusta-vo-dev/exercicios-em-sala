Program ex_25 ;

type
	reg_pessoas = record;
		nome: string[30];
		nome_inv: string[30];
		ddd: integer;
		telefone: string[10];
	end;	
		
	vet_pessoas = array[1..3] of reg_pessoas;
	
	var lista: vet_pessoas;
			i: integer;

Begin

End. 