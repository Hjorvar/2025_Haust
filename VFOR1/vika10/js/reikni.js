const display = document.getElementById('display');

function appendToDisplay(input) {
    display.value += input;
}

function clearDisplay() {
    display.value = '';
}

function calculateResult() {
    try {
        const result = eval(display.value);
        // Display the result.
        display.value = result;
    } catch (error) {
        display.value = 'Error';
    }
}