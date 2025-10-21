function mostrarsenha (){
            let input = document.querySelector("#senha");
            if (input.type === "password"){
                input.type = "text";
                mostrar.innerText = "Mostrar Senha";
            }else{
                input.type = "password";
                mostrar.innerText = "Ocultar Senha";
            }
        }  

//Mudar cor de fundo//
function clicou(){
    let cores = ["lightblue", "red", "green", "lightgray", "lightgreen"];
        let corAleatoria = cores[Math.floor(Math.random() * cores.length)];
        document.body.style.backgroundColor = corAleatoria;
}

function tamanho(){
    let imagem = document.querySelector("#tamanhoimg");

}


