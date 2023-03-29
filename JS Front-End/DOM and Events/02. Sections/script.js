function create(words) {
   let contentContainer = document.getElementById('content');
   
   words.forEach(w => {
      let divContainer = document.createElement('div');
      let paragraph = document.createElement('p');
      paragraph.textContent = w;
      paragraph.style.display = 'none';
      divContainer.appendChild(paragraph);
      divContainer.addEventListener('click', () => {paragraph.style.display = 'block'});
      contentContainer.appendChild(divContainer);
   });
}