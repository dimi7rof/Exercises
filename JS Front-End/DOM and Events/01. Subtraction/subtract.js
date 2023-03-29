function subtract() {
    let one = document.getElementById('firstNumber').value;
    let two = document.getElementById('secondNumber').value;
    let result = one - two;
    let something = document.getElementById('result');
    something.textContent = result;
}