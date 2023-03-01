// 01 Ages

function ages(age) {
    if (age >= 0 && age < 3) { return 'baby' }
    if (age >= 3 && age < 14) { return 'child' }
    if (age >= 14 && age < 20) { return 'teenager' }
    if (age >= 20 && age < 66) { return 'adult' }
    if (age >= 66) { return 'elder' }
    return 'out of bounds'
}

// 02 Vacation

function vacation(people, groupType, dayOfWeek) {
    let price = 0;
    if (groupType === 'Students') {
        price = 8.45;
        if (dayOfWeek === 'Saturday') {
            price = 9.8;
        }
        if (dayOfWeek === 'Sunday') {
            price = 10.46;
        }
        if (people >= 30) {
            price *= 0.85;
        }
    }
    else if (groupType === 'Business') {
        price = 10.9;
        if (dayOfWeek === 'Saturday') {
            price = 15.6;
        }
        if (dayOfWeek === 'Sunday') {
            price = 16;
        }
        if (people >= 100) {
            people -= 10;
        }
    }
    else if (groupType === 'Regular') {
        price = 15;
        if (dayOfWeek === 'Saturday') {
            price = 20;
        }
        if (dayOfWeek === 'Sunday') {
            price = 22.5;
        }
        if (people >= 10 && people <= 20) {
            price *= 0.95;
        }
    }
    price *= people;
    console.log('Total price: ' + price.toFixed(2));
}

// 03. Leap Year

function leapYear(year) {
    let leap = false;
    if (year % 4 == 0) {
        leap = true;
        if (year % 100 == 0) {
            leap = false;
            if (year % 400 == 0) {
                leap = true;
            }
        }
    }
    console.log(leap ? 'yes' : 'no');
}

// 04 Print and Sum

function printAndSum(x, y) {
    let sum = 0;
    let arr = [];
    for (let i = x; i <= y; i++) {
        sum += i;
        arr.push(i);
    }
    console.log(arr.join(' '));
    console.log('Sum: ' + sum);
}

// 05. Multiplication Table

function multiplication(x) {
    for (let i = 1; i <= 10; i++) {
        console.log(x + ' X ' + i + " = " + x * i);
    }
}

// 06. Sum Digits

function sumDigits(num) {
    let sum = 0;
    num = String(num);
    for (let i = 0; i < num.length; i++) {
        sum += Number(num[i]);
    }
    console.log(sum);
}

// 07. Chars to String

function charToString(x, y, z) {
    let arr = [];
    arr.push(x, y, z);
    console.log(arr.join(''));
}

// 08. Reversed Chars

function reversedChars(x, y, z) {
    let arr = [];
    arr.push(z, y, x);
    console.log(arr.join(' '));
}

// 09. Fruit

function fruit(text, weight, price) {
    weight = weight / 1000;
    let money = weight * price;
    console.log(`I need $${money.toFixed(2)} to buy ${weight.toFixed(2)} kilograms ${text}.`);
}

// 10. Same Numbers     83/100

function sameNumbers(num) {
    let sum = 0;
    let same = false;
    num = String(num);
    for (let i = 0; i < num.length; i++) {
        sum += Number(num[i]);
    }
    for (let i = 1; i < num.length; i++) {
        if (num[i] == num[i - 1]) {
            same = true;
        }
        else {
            same = false;
            break;
        }
        
    }
    console.log(same ? 'true' : 'false');
    console.log(sum);
}

sameNumbers(2222322);
sameNumbers(222222);
sameNumbers(2222922);


// 11. Road Radar



function roadRadar(speed, area) {
    let status = 'speeding';
    let speeding = false;
    let diff = 0;
    let allowedSpeed = 0;
    if (area == 'residential') {
        allowedSpeed = 20;
    }
    else if (area == 'city') {
        allowedSpeed = 50;
    }
    else if (area == 'interstate') {
        allowedSpeed = 90;
    }
    else if (area == 'motorway') {
        allowedSpeed = 130;
    }
    if(speed > allowedSpeed + 40){
        status = 'reckless driving';
        speeding = true;
    }
    else if (speed > allowedSpeed + 20){
        status = 'excessive speeding';
        speeding = true;
    }
    else if (speed > allowedSpeed){
        speeding = true;
    }
    diff = speed - allowedSpeed;
    if (speeding){
        console.log(`The speed is ${diff} km/h faster than the allowed speed of ${allowedSpeed} - ${status}`)
    }
    else {
        console.log(`Driving ${speed} km/h in a ${allowedSpeed} zone`
        )
    }
}

// 12. Cooking by Numbers

function cooking(x, ...params){
    let num = Number(x);
    for (let i = 0; i < params.length; i++) {
        if (params[i] == 'chop'){
            num = num /2;
        }
        else if (params[i] == 'dice'){
            num = Math.sqrt(num);
        }
        else if (params[i] == 'spice'){
            num++;
        }
        else if (params[i] == 'bake'){
            num = num * 3;
        }
        else if (params[i] == 'fillet'){
            num = num * 0.8;
        }
    console.log(num);
    }

}

// 13. Array Rotation

function arrayRotation(arr, x){
    for (let i = 0; i < x; i++) {
        arr.push(arr.shift());
    }
    console.log(arr.join(' '));
}

// 14. Print every N-th Element from an Array

function printEveryNthElement(arr, x){
    let output = [];
    for (let i = 0; i < arr.length; i += x) {
        output
        output.push(arr[i]);
    }
    return output;
}

// 15. List Of Names

function listOfNames(arr){
    let output = arr.sort((a, b) => a.localeCompare(b));
   for (let i = 1; i <= output.length; i++) {
    console.log(`${i}.${output[i-1]}`)
   }
}

// 16. Sorting Numbers

function sortNumbers(arr){
    arr.sort((a, b) => { return a - b});
    let output = [];
    let len = arr.length;
    for (let i = 0; i < len; i++) {
        if (i % 2 == 0) {
            output.push(arr.shift());
        }
        else
            output.push(arr.pop());
    }
    return output;
}

// 17. Reveal Words

function revealWords(word, text){
    let wordArray = word.split(', ');
    for (let i = 0; i < wordArray.length; i++) {
        text = text.replace('*'.repeat(wordArray[i].length), wordArray[i]);
    } 
    console.log(text);
}

// 18. Modern Times of #(HashTag)   

function modernTimes(text){
    return text
    .split(' ')
    .filter(x => x.startsWith('#') 
        && x.length > 1
        && /^#[A-z]*$/.test(x))
    .map(x => x.slice(1))
    .join('\n')
}

// 19. String Substring

function stringSubstrin(testWord, text1){
    let text = text1.split(' ');
    for (const word of text) {
        if (word.toLowerCase() === testWord.toLowerCase()) {
            return testWord;
        }
    }
    return `${testWord} not found!`
}

// 20. Pascal-Case Splitter

function pascalCaseSpliter(text) {
    return text.split(/(?=[A-Z])/).join(', ');
}




