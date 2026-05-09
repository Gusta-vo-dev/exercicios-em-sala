<<<<<<< HEAD
Program Program_1 ;

const max=3;

type 
	vet = array[1..max] of integer;
	
var fila: Tfila;
		valor,inicio,fim:integer;

	procedure iniciar( var f: Tfila);
	begin
			f.inicio:= 1;
			f.fim:= 0;
	end; 
	
	procedure inserir ( var f: Tfila; var valor: integer);
	begin
	   if f.fim = max then
	   		writeln('A fila está cheia!')
	   else
	   begin
	   		if f.inicio = 0 then 
				 	f.inicio:= 1;
				f.fim:= f.fim + 1;
				f.dados[f.fim]:= valor;
	   end;		
	end;

Begin
  	inserir(fila,12);
  	writeln(val);
End.
=======
Program Pzim ;
   
	const max = 6;
  type vetor=array[1..max] of integer;
 
   function cheia(posicao, maximo:integer):boolean;
    begin
       cheia:= posicao > maximo;
    end;
   
    function vazio(posicao:integer):boolean;
    begin
       vazio:= posicao = 0;
    end;
   
  procedure inserir(var vet:vetor;var posicao:integer;maxi:integer);
    var prox:integer;
    begin
       posicao:= posicao +1;
       if not cheia(posicao,maxi) then
        begin
             writeln ('digite o proximo da fila');
           readln (prox);
           vet[posicao]:= prox;
          end
             else
         writeln ('sua fila esta cheia');            
    end;
   
  procedure remover(var vet:vetor;var posicao:integer);
    var i:integer;
    begin
       if not vazio(posicao) then
        begin
           for i:=1 to posicao do
            begin
                      vet[i]:=vet[i+1]
            end;
            posicao:= posicao - 1;
          end
       else
         writeln ('sua fila esta vazia');
    end;
   
  procedure consultar (vet:vetor;posicao:integer);
   begin
      if not vazio(posicao) then
           writeln('proximo da fila:',vet[1])
           else
           writeln('insira o valor primeiro')
   end;
   
   procedure escrever(vet:vetor; posicao:integer);
     var i:integer;
    begin
       if not vazio(posicao) then
       begin
           for i := 1 to posicao do
                   write(vet[i],'| ');
                     writeln;
             end
             else
                writeln('insira o valor primeiro')
    end;
   
   
     var op: byte;
         fila:vetor;
         posi:integer;
Begin
      repeat
        writeln ('=====MENU=====');
        writeln ('1- inserir');
        writeln ('2- remover');
        writeln ('3- consultar');
        writeln ('4- escrever');
        writeln ('0- sair');
        readln(op);
        case (op ) of
          1: inserir(fila,posi,max) ;
          2: remover(fila,posi) ;
          3: consultar(fila,posi) ;
          4: escrever(fila,posi) ;
                    0: writeln('saindo...') ;
        end;
      until ( op = 0 );
End.

>>>>>>> b752098bcf8208693c4836a3109bf4977994a104
