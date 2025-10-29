const wordDisplay = document.querySelector('.word-display');
const guessesLeftDisplay = document.querySelector('#mistakes');
const maxMistakesDisplay = document.querySelector('#max-mistakes');
const keyboardDiv = document.querySelector('.keyboard');
const figureParts = document.querySelectorAll('.figure-part');
const gameMessage = document.querySelector('#game-message');
const resetButton = document.querySelector('#reset-button');

const wordList = [  
                    "FORRITUN", 
                    "VEFSÍÐA", 
                    "TÖLVA", 
                    "KENNARI", 
                    "NEMANDI", 
                    "JAVASCRIPT", 
                    "STYLESHEET", 
                    "MARKUP", 
                    "VIÐMÓT", 
                    "NOTANDI"
                ];
       
const MAX_MISTAKES = 6;

let currentWord = '';
let guessedLetters = [];
let mistakes = 0;
let gameActive = true;


const selectWord = () => {
    return wordList[Math.floor(Math.random() * wordList.length)];
};

const displayWord = () => {
    wordDisplay.textContent = currentWord
        .split('')
        .map(letter => (guessedLetters.includes(letter) ? letter : '_'))
        .join('');

    checkWinCondition();
};

const updateMistakes = () => {
    guessesLeftDisplay.textContent = mistakes;
    figureParts.forEach((part, index) => {
        part.style.display = index < mistakes ? 'block' : 'none';
    });
    checkLoseCondition();
};

const createKeyboard = () => {
    keyboardDiv.innerHTML = '';
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚÝÞÆÖÐ'.split('');
    alphabet.forEach(letter => {
        const button = document.createElement('button');
        button.textContent = letter;
        button.addEventListener('click', () => handleGuess(letter));
        keyboardDiv.appendChild(button);
    });
};

const handleGuess = (letter) => {
    if (!gameActive || guessedLetters.includes(letter)) return;

    guessedLetters.push(letter);
    document.querySelectorAll('.keyboard button').forEach(btn => {
        if (btn.textContent === letter) {
            btn.disabled = true;
        }
    });

    if (currentWord.includes(letter)) {
        displayWord();
    } else {
        mistakes++;
        updateMistakes();
    }
};

const checkWinCondition = () => {
    if (gameActive && wordDisplay.textContent === currentWord) {
        endGame(true);
    }
};

const checkLoseCondition = () => {
    if (gameActive && mistakes >= MAX_MISTAKES) {
        endGame(false);
    }
};

const endGame = (won) => {
    gameActive = false;
    if (won) {
        gameMessage.textContent = 'Þú vannst!';
        gameMessage.style.color = 'green';
    } else {
        gameMessage.textContent = `Þú tapaðir! Orðið var: ${currentWord}`;
        gameMessage.style.color = 'red';
        wordDisplay.textContent = currentWord;
    }
    resetButton.classList.remove('hide');
    disableKeyboard();
};

const disableKeyboard = () => {
    document.querySelectorAll('.keyboard button').forEach(btn => {
        btn.disabled = true;
    });
};

const resetGame = () => {
    mistakes = 0;
    guessedLetters = [];
    currentWord = selectWord();
    gameActive = true;
    gameMessage.textContent = '';
    resetButton.classList.add('hide');

    maxMistakesDisplay.textContent = MAX_MISTAKES;
    displayWord();
    updateMistakes();
    createKeyboard();
};

resetGame();
resetButton.addEventListener('click', resetGame);