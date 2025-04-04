function agregarNumero(num) {
    document.getElementById("display").value += num;
}

function agregarOperador(op) {
    let display = document.getElementById("display");
    let valorActual = display.value;
    
    if (valorActual.length > 0 && "+-*/.".includes(valorActual.slice(-1)) === false) {
        display.value += op;
    }
}

function calcularResultado() {
    let display = document.getElementById("display");
    try {
        display.value = eval(display.value);
    } catch (e) {
        display.value = "Error";
    }
}

function borrarDisplay() {
    document.getElementById("display").value = "";
}
