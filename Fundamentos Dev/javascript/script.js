alert ("Olá, Mundo");
console.log("Teste");

let idade = 18;
console.log(idade);

let nome = "Gustavo";
let sobrenome = "Pickler Vieira";
let NomeCompleto = nome + ' ' + sobrenome;
console.log(NomeCompleto);

let logado = true;

//Vetor//
let lista= ["ovo", "trigo", "leite"];
console.log('A ordem da lista é: ', lista);


                       //Operações com variáveis//
let  x = 0;
x = x + 1;
console.log('x=', x);

let x2 = '2';
let resultado= x + x2;
console.log(resultado);

//Subtração//
let a = 10;
let b = 5;
resultado = a - b;
console.log(resultado); 

//Divisão//
resultado = a / b;
console.log(resultado);

//Multiplicação//
resultado = a * b; 
console.log(resultado);
if (resultado > 40){
    alert ('BINGO: ' + resultado);
}

else {
    alert("Not Bingo");
}
/* == Não analisa o tipo
   === Analisa o tipo
   != Diferente que não analisa o tipo
   !== Diferemte que analisa o tipo
*/


//Condição dentro de Condição

if (idade >= 18){
    if (idade >= 60){
        console.log ("Idoso");
    }
    else{
        console.log("Adulto");
    }
}
else{
    console.log("É menor de idade");
}

//Multi Condicionais//
if (idade => 18 && idade < 60) {
    console.log("Adulto...");
}

let verifica = true;
if (verifica){
    console.log("verdadeira");
}
else{
    console.log('Falsa');
}

//Loop de Repetição//
for (let i = 0; i < 5; i++){
    console.log('Número: ', i)
}

let contador = 0;
while (contador < 5){
    console.log("CONTAGEM EM: ", contador);
    contador = contador + 1;
}