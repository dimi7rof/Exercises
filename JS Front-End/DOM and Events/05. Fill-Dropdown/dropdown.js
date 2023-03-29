function addItem() {
    let itemText = document.getElementById('newItemText');
    let itemValue = document.getElementById('newItemValue');
    let menu = document.getElementById('menu');
    let option = document.createElement('option');
    option.textContent = itemText.value;
    option.value = itemValue.value;
    menu.appendChild(option);
    itemText.value = '';
    itemValue.value = '';
}