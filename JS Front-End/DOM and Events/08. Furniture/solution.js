function solve() {
  let textareas = document.getElementsByTagName('textarea');
  let generateBtn = document.getElementsByTagName('button')[0];
  generateBtn.addEventListener('click', generateHandler2);
  
  function generateHandler2(){
    let input = JSON.parse(textareas[0].value);
    let tableBody = document.querySelector('.table > tbody');
    for (const {img, name, price, decFactor} of input) {
      let tableRow = createElement('tr', tableBody);
      let td0 = createElement('td', tableRow);
      createElement('img', td0,'', {src: img});
      let td1 = createElement('td', tableRow);
      createElement('p', td1, name);
      let td2 = createElement('td', tableRow);
      createElement('p', td2, price);
      let td3 = createElement('td', tableRow);
      createElement('p', td3, decFactor);
      let td4 = createElement('td', tableRow);
      createElement('input', td4, '', {type: 'checkbox'});
    }
  }

  let buyBtn = document.querySelector('#exercise > button:nth-child(6)');
  buyBtn.addEventListener('click', buyHandler);

  function buyHandler() {
    let checkboxes = Array.from(document.querySelectorAll('input:checked'));
    let names = [];
    let prices = 0;
    let decFactors = 0;
    checkboxes = checkboxes.filter((c) => c.checked);
    
    for (const check of checkboxes) {
      let checkParent = check.parentElement;
      let row = checkParent.parentElement;
      names.push(row.querySelector('td > p').innerText);
      prices += Number(row.querySelector('td:nth-child(3) > p').innerText);
      decFactors += Number(row.querySelector('td:nth-child(4) > p').innerText);
    }
    
    textareas[1].value += `Bought furniture: ${names.join(', ')}\n`;
    textareas[1].value += `Total price: ${prices.toFixed(2)}\n`;
    textareas[1].value += `Average decoration factor: ${decFactors / checkboxes.length}`;
  }

    function createElement(type, parent, content, attributes) {
      let htmlElement = document.createElement(type);
      if(content) {
        htmlElement.innerText = content;
      }
      if (attributes) {
        for (const key in attributes) {
          htmlElement.setAttribute(key, attributes[key]);
        }
      }
      parent.appendChild(htmlElement);
      return htmlElement;
      }
   // function generateHandler() {
  //   for (let i = 0; i < input.length; i++) {
  //     let tr = document.createElement('tr');
  //     let img = document.createElement('img');
  //     img.src = input[i].img;
  //     let td = document.createElement('td');
  //     td.appendChild(img);
  //     tr.appendChild(td);
      
  //     let name = document.createElement('p');
  //     name.innerText = input[i].name;
  //     td = document.createElement('td');
  //     td.appendChild(name);
  //     tr.appendChild(td);
      
  //     let price = document.createElement('p');
  //     price.innerText = input[i].price;
  //     td = document.createElement('td');
  //     td.appendChild(price);
  //     tr.appendChild(td);
      
  //     let decFactor = document.createElement('p');
  //     decFactor.innerText = input[i].decFactor;
  //     td = document.createElement('td');
  //     td.appendChild(decFactor);
  //     tr.appendChild(td);
      
  //     let checkbox = document.createElement('input');
  //     checkbox.type = 'checkbox';
  //     td = document.createElement('td');
  //     td.appendChild(checkbox);
  //     tr.appendChild(td);
      
  //     tableBody.appendChild(tr);
  //   }
  // }
}