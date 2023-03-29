function solve() {
  let text = document.getElementById('input').value;
  let sentences = text.split('.')
   .map((s) => s.trimStart());
  sentences.pop();
  let output = document.getElementById('output');
  
  while (sentences.length > 0) {
    let sentencesBy3 = sentences.splice(0, 3) + '.';
    let paragraph = document.createElement('p');
    paragraph.innerText = sentencesBy3;
    output.appendChild(paragraph);
  }
}