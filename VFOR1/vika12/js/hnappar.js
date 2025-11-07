const button = document.querySelector('.my-button');
button.addEventListener('click', () => {
    alert('Button was clicked!');
    // change body background
    if (document.body.style.backgroundColor === 'lightblue') {
        document.body.style.backgroundColor = 'black';
    } else {
        document.body.style.backgroundColor = 'lightblue';
    }
});