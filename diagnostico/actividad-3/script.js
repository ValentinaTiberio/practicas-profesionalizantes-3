// Funciones
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

// Controladores números
document.getElementById("btn0").addEventListener("click", () => agregarNumero("0"));
document.getElementById("btn1").addEventListener("click", () => agregarNumero("1"));
document.getElementById("btn2").addEventListener("click", () => agregarNumero("2"));
document.getElementById("btn3").addEventListener("click", () => agregarNumero("3"));
document.getElementById("btn4").addEventListener("click", () => agregarNumero("4"));
document.getElementById("btn5").addEventListener("click", () => agregarNumero("5"));
document.getElementById("btn6").addEventListener("click", () => agregarNumero("6"));
document.getElementById("btn7").addEventListener("click", () => agregarNumero("7"));
document.getElementById("btn8").addEventListener("click", () => agregarNumero("8"));
document.getElementById("btn9").addEventListener("click", () => agregarNumero("9"));

// Controladores operadores
document.getElementById("btnSumar").addEventListener("click", () => agregarOperador("+"));
document.getElementById("btnRestar").addEventListener("click", () => agregarOperador("-"));
document.getElementById("btnMultiplicar").addEventListener("click", () => agregarOperador("*"));
document.getElementById("btnDividir").addEventListener("click", () => agregarOperador("/"));
document.getElementById("btnPunto").addEventListener("click", () => agregarOperador("."));

// Controladores especiales
document.getElementById("btnIgual").addEventListener("click", calcularResultado);
document.getElementById("btnBorrar").addEventListener("click", borrarDisplay);
