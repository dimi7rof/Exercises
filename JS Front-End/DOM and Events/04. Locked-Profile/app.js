function lockedProfile() {
    let buttons = document.querySelectorAll('button');
    for (const btn of buttons) {
        btn.addEventListener('click', handleclick);
    }

    function handleclick(e) {
        let parent = e.target.parentElement;
        let div = parent.children[9];
        let locked = parent.children[2];
        if (locked.checked) {
            return;
        }
        if( e.target.textContent === 'Show more') {
            div.style.display = 'block';
            e.target.textContent = 'Hide it';
        }
        else {
            div.style.display = 'none';
            e.target.textContent = 'Show more';
        }
    }
}