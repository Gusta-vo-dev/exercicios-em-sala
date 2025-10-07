let nome = 'Gustavo';
let idade = 18;
let cidade = 'Petrolândia';
console.log('Olá, meu nome é', nome, ' tenho ', idade, ' anos e moro em ', cidade);

for (let i = 0; i < 10; i++){
    console.log('Número: ', i);
}

for (let i = 0; i < 10; i++){
   if ( i % 2 == 1 ){
    console.log('O número ', i, ' é impar');
   }
} 

let contador = 0;
let fixo = 5;
while (contador < 10){
    let multi = contador * 5;
    console.log(fixo, ' x ', contador, ' = ', multi);
    contador = contador + 1;
}