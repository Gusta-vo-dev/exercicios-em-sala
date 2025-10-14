//Exercício 01
function porcentagem(num, total){
    return (num * total) / 100;
}

let resultado = porcentagem(25, 40);
console.log(resultado);


//exercício 02
let m2 = "3000";
let quartos = "2";
function imovel(m2, metros, quartos){
    if (quartos == "2"){
        valor = (m2 * 1.2) * 100;
    }
    else if ( quartos >= "3") {
        m2 = m2 * 1.5;
    }
}

console.log( 'O preço do imóvel é: ' + m2 * metros);
imovel ("3000", "100", "2");


//Exercício 03
let usuario = "pedro";
let senha = "123";
function verifica( usuario, senha){
    if ( usuario == "pedro" && senha == "123"){
        return true;
    }
    else {
        return false;
    }
}

let valida = verifica(usuario, senha);
console.log (valida);


//Raiz Quadrada
