function solve() {
   document.querySelector('#searchBtn').addEventListener('click', onClick);

   function onClick() {
      let searchField = document.getElementById('searchField');

      Array.from(document.querySelectorAll('body > table > tbody > tr'))
         .forEach((r) => r.classList.remove('select'));

      Array.from(document.querySelectorAll('body > table > tbody > tr > td'))
         .forEach((x) => {
            if (x.innerHTML.includes(searchField.value)) {
               x.parentElement.classList.add('select');
            }
         });
         
      searchField.value = '';
   }
}