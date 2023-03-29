function toggle() {
    let content = document.getElementById("extra");
    let btn = document.getElementsByClassName('button')[0];
    if (btn.innerHTML.toLowerCase() == 'more') {
        btn.innerHTML = 'Less';
        content.style.display = 'block';
    }
    else {
        btn.innerHTML = 'More';
        content.style.display = 'none';
    }
}