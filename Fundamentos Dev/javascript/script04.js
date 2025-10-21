function clicou (){
    let botao = document.querySelector("#enviamsg");
    console.log(botao);

    let h1 = document.querySelector("h1");
    console.log(h1);

    h1.innerHTML = "Outro Texto";
    h1.style.color = "red"

    let body = document.querySelector('body');
    body.style.backgroundColor = "black";
    body.style.color = "white";
    
    let paragrafo = document.querySelector("#paragrafo");
    paragrafo.textContent = "Mudei o Texto";
    paragrafo.style.fontSize = "24px";

    let numero = document.querySelector("#numero").value;
    alert("Número informado foi: " + numero);
}