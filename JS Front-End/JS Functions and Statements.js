// 01. Smallest of Three Numbers

function printSmallestNumber(...params){
    return Math.min(...params);
}
//console.log(printSmallestNumber(2, 5, 3));

// 02. Add and Subtract

function addAndSubtract(a, b, c) {
    return a + b - c;
}
//console.log(addAndSubtract(1, 17, 30));

// 03. Characters in Range          0

function charInRange(a, b) {
    if (ascii(b) < ascii(a)) {
        let temp = a;
        a = b;
        b = temp;
    }
    let outputArray = [];
    for (let i = ascii(a) + 1; i < ascii(b); i++) {
        outputArray.push(String.fromCharCode(i));   
    }
    return outputArray.join(' ');
    function ascii (c) { 
        return c.charCodeAt(0); 
    }
}
//console.log(charInRange('C', '#'));

// 04. Odd And Even Sum

function oddAndEvenSum(number) {
    let numAsStringArr = [...number.toString()];
    let sumOdd = 0;
    let sumEven = 0;
    for (let i = 0; i < numAsStringArr.length; i++) {
        if (Number(numAsStringArr[i]) % 2 !== 0) {
            sumOdd += Number(numAsStringArr[i]);
        }
        else {
            sumEven += Number(numAsStringArr[i]);
        }
    }
    return `Odd sum = ${sumOdd}, Even sum = ${sumEven}`
}
//console.log(oddAndEvenSum(1000435));
//console.log(oddAndEvenSum(3495892137259234));

// 05. Palindrome Integers

function palindromeIntegers(intArray) {
    for (let j = 0; j < intArray.length; j++) {
        let num = intArray[j].toString();
        let palindrome = true;
        for (let i = 0; i < num.length / 2; i++) {
            if (num[i] !== num[num.length - i - 1]) {
                palindrome = false;
                break;
            }
        }
        console.log(palindrome ? 'true' : 'false');
    }
}
//palindromeIntegers([123,323,421,121]);
//palindromeIntegers([32,2,232,1010]);

// 05. Palindrome Integers v2

function palindromeInts(numbers) {
    return numbers
        .map((num) => Number([...num.toString()].reverse().join('')) === num)
        .join('\n');
}
//console.log(palindromeInts([123,323,421,121]))

// 06. Password Validator   85/100

function passwordValidator(password) {
    let validPassword = true;
    if (password.length < 6 || password.length > 10) {
        console.log('Password must be between 6 and 10 characters');
        validPassword = false;
    }
    if (password.match(/[^a-zA-Z0-9_]/)) {
        console.log('Password must consist only of letters and digits');
        validPassword = false;
    }
    if (!password.match(/[0-9]*[0-9]/)) {
        console.log('Password must have at least 2 digits');
        validPassword = false;
    }
    if (validPassword) {
        console.log('Password is valid')
    }
}
// passwordValidator('logIn');
// passwordValidator('MyPass123');
// passwordValidator('Pa$s$s');

// 07. NxN Matrix

function nxnMatrix(number){
    for (let i = 0; i < number; i++) {
        let row = [];
        for (let j = 0; j < number; j++) {
            row.push(number)
        }
        console.log(row.join(' '));
    }
}
//nxnMatrix(7);

// 08. Perfect Number

function perfectNumber(number) {
    function checkDevisors(num) {
        let sum = 1;
        for (let i = 2; i < num / i; i++) {
            if (num % i === 0) {
             sum += i + num / i;
            }
        }
        const sqrt = Math.sqrt(num);
        return (num % sqrt === 0 ? sum + sqrt : sum);
    }
    if (checkDevisors(number) === number) {
        return 'We have a perfect number!';
    }
    return "It's not so perfect.";
}
//console.log(perfectNumber(28));

// 09. Loading Bar

function loadingBar(number) {
    if (number == 100) {
        return '100% Complete!\n[%%%%%%%%%%]';
    }
    else {
        let array = [];
        for (let i = 1; i <= 10; i++) {
            if (i <= (number / 10)) {
                array.push('%');
            }
            else {
                array.push('.');
            }
        }
        return `${number}% [${array.join('')}]\nStill loading...`;
    }
}
//console.log(loadingBar(90));

// 10. Factorial Division

function factorialDivision(a, b) {
    function factorial(x) {
        if (x == 0) {
            return 1;
        }
        return x * factorial(x - 1);
    }
    return (factorial(a) / factorial(b)).toFixed(2);
}
//console.log(factorialDivision(5, 2));
