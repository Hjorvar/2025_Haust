const gameStates = {
    start: {
        text: "Þú vaknar einn í myrkri helli. Fyrir framan þig eru tveir stígar. Hvaða leið velurðu?",
        options: [
            { text: "Fara vinstri", nextState: "leftPath" },
            { text: "Fara hægri", nextState: "rightPath" }
        ]
    },
    leftPath: {
        text: "Þú ferð vinstri og finnur lítinn ljósa stein. Hann lýsir upp stíginn og þú sérð hurð fyrir framan þig.",
        options: [
            { text: "Opna hurðina", nextState: "openDoor" },
            { text: "Halda áfram á stígnum", nextState: "deadEnd" }
        ]
    },
    rightPath: {
        text: "Hægri stígurinn endar í laugarvatni. Þú horfir á spegilmynd þína, þú ert orðinn mjög gamall, en einhvern veginn þetta skiptir þig ekki máli.",
        options: [
            { text: "Byrja upp á nýtt", nextState: "start" }
        ]
    },
    openDoor: {
        text: "Þú opnar hurðina og kemur að stóru hvíldarherbergi. Þú tekur eftir því að galdrakarl er fyrir framan þig, og í hönd hans er gull.",
        options: [
            { text: "Ræna gullinu", nextState: "robWizard" },
            { text: "Heilsa upp á hann", nextState: "friendlyWizard" }
        ]
    },
    robWizard: {
        text: "Þú stekkur á galdrakarlinn, en hann er of fljótur. Hann breytir þér í gullstyttu. Leik lokið.",
        options: [
            { text: "Byrja upp á nýtt", nextState: "start" }
        ]
    },
    friendlyWizard: {
        text: "Galdrakarlinn er vinalegur og bauðst þér að gista í höllinni sinni. Þið urðuð bestu vinir. Þið unnuð gullið saman.",
        options: [
            { text: "Byrja upp á nýtt", nextState: "start" }
        ]
    },
    deadEnd: {
        text: "Þú gengur lengra eftir stígnum og finnur vegg. Þú ert fastur. Leik lokið.",
        options: [
            { text: "Byrja upp á nýtt", nextState: "start" }
        ]
    },
};

// DOM elementin
const gameTextElement = document.getElementById('game-text');
const optionButtonsElement = document.getElementById('option-buttons');
const restartButton = document.getElementById('restart-button');

// Fall til að sýna leikinn
function showState(state) {
    const currentState = gameStates[state];
    gameTextElement.innerText = currentState.text;
    optionButtonsElement.innerHTML = '';

    currentState.options.forEach(option => {
        const button = document.createElement('button');
        button.innerText = option.text;
        button.classList.add('option-button');
        button.addEventListener('click', () => selectOption(option));
        optionButtonsElement.appendChild(button);
    });
}

function selectOption(option) {
    if (option.nextState === 'start') {
        startGame();
    } else {
        showState(option.nextState);
    }
}

function startGame() {
    showState('start');
}

startGame();