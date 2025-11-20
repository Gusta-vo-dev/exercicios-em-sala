Program ex_36 ;

const max = 3;

var v: array[1..max] of integer;
		i: integer;
		ordem: string[1];
		
procedure vet_ordem (vetor: v; orde: string[1]);		
	begin
	   if orde = 'C' then
	end;	
		

Begin
  for i:=1 to 10 do
  begin
  	 write ('Digite o ', i, 'º número do vetor: ');
  	 readln ( v[i] );
  end;
  write ('Que ordem você quer o vetor? (C- Correta  I- Inversa)');
  readln ( ordem );
  vet_ordem ( v, ordem );
End.