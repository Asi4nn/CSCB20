let num1 = '';
let num2 = '';
let operator = '';
let total = '';

$(document).ready(function() {
    $('button').on('click', function(e) {
        let btn = e.target.innerHTML;
        if (btn >= '0' && btn <= '9') {
            handleNumber(btn);
        }
        else {
            handleOperator(btn);
        }
    });
});

function displayButton(btn) {
    $('.calc-result-input').text(btn);
}

function handleNumber(num) {
    if (num1 === '') {
        num1 = num;
    }
    else {
        num2 = num;
    }
    displayButton(num);
}

function handleTotal() {
    switch (operator) {
        case '+':
            total = +num1 + +num2;
            displayButton(total);
            break;
        case '-':
            total = +num1 - +num2;
            displayButton(total);
            break;
        case '/':
            total = +num1 / +num2;
            displayButton(total);
            break;
        case 'X':
            total = +num1 * +num2;
            displayButton(total);
            break;
    }
    updateVariables();
}

function updateVariables() {
    num1 = total;
    num2 = '';
}

function handleOperator(oper) {
    if (operator === '') {
        operator = oper;
    }
    else {
        handleTotal();
        operator = oper;
    }
}



