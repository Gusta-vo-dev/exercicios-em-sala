function abreWhats(fone, msg) {
    acao = "https://web.whatsapp.com/send/?phone="+fone+"&text="+msg;
    window.open(acao,"_blank");
}