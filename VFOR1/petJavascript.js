/**
 * js/dashboard.js
 * Þessi skrá keyrir aðeins á dashboard.html.
 * Hún stjórnar allri virkni gæludýrsins.
 */

// Geymum tilvísanir í DOM-þætti sem við notum oft
let petNameHeader, petImage, statHunger, statHappiness, statEnergy, petStatusMessage;

document.addEventListener('DOMContentLoaded', () => {
    // === ÖRYGGISVÖRÐUR (Auth Guard) ===
    // Ef enginn er innskráður (currentUser er null úr data.js),
    // sendum við notandann aftur á innskráningarsíðu.
    if (!currentUser) {
        alert('Þú verður að vera innskráður til að sjá þessa síðu.');
        window.location.href = 'index.html';
        return; // Stöðvum keyrslu á restinni af skránni
    }

    // === VELJA DOM ÞÆTTI ===
    // (Við gerum þetta hér svo við þurfum ekki að leita að þeim aftur og aftur)
    petNameHeader = document.querySelector('#pet-name-header');
    petImage = document.querySelector('#pet-image');
    statHunger = document.querySelector('#stat-hunger');
    statHappiness = document.querySelector('#stat-happiness');
    statEnergy = document.querySelector('#stat-energy');
    petStatusMessage = document.querySelector('#pet-status-message');

    // === TENJA ATBURÐI (EVENT LISTENERS) ===
    document.querySelector('#btn-feed').addEventListener('click', handleFeed);
    document.querySelector('#btn-play').addEventListener('click', handlePlay);
    document.querySelector('#btn-sleep').addEventListener('click', handleSleep);
    document.querySelector('#logout-btn').addEventListener('click', handleLogout);

    // === FYRSTA UPPHLEÐSLA ===
    // Birtum gögnin um gæludýrið um leið og síðan hleðst
    renderDashboard();
});

/**
 * Þetta fall les gögnin úr `currentUser.pet` og uppfærir
 * allt HTML á síðunni til að endurspegla nýju stöðuna.
 */
function renderDashboard() {
    const pet = currentUser.pet; // Bara til að stytta kóðann

    // Uppfærum texta
    petNameHeader.textContent = `Mælaborð: ${pet.petName}`;
    statHunger.textContent = pet.hunger;
    statHappiness.textContent = pet.happiness;
    statEnergy.textContent = pet.energy;

    // Uppfærum mynd og stöðuskilaboð (Rökfræði!)
    if (pet.hunger > 80) {
        pet.imageSrc = 'images/pet-hungry.png'; // (Mynd þarf að vera til)
        petStatusMessage.textContent = `${pet.petName} er mjög svangur!`;
    } else if (pet.happiness < 20) {
        pet.imageSrc = 'images/pet-sad.png'; // (Mynd þarf að vera til)
        petStatusMessage.textContent = `${pet.petName} er leiður.`;
    } else if (pet.energy < 20) {
        pet.imageSrc = 'images/pet-tired.png'; // (Mynd þarf að vera til)
        petStatusMessage.textContent = `${pet.petName} er þreyttur.`;
    } else {
        pet.imageSrc = 'images/pet-neutral.png'; // (Mynd þarf að vera til)
        petStatusMessage.textContent = `${pet.petName} líður vel.`;
    }

    // Uppfærum myndina á síðunni
    petImage.setAttribute('src', pet.imageSrc);
}

/**
 * Keyrt þegar smellt er á "Gefa mat".
 * Breyir gögnin og kallar svo á render.
 */
function handleFeed() {
    if (currentUser.pet.energy < 10) {
        alert(`${currentUser.pet.petName} er of þreyttur til að borða.`);
        return;
    }
    
    currentUser.pet.hunger -= 15; // Verður saddari (talan lækkar)
    currentUser.pet.energy -= 5;  // Borða kostar smá orku
    
    // Gætum þess að tölur fari ekki undir 0
    if (currentUser.pet.hunger < 0) currentUser.pet.hunger = 0;
    if (currentUser.pet.energy < 0) currentUser.pet.energy = 0;

    saveState(); // Vistum nýju stöðuna
    renderDashboard(); // Endurteiknum síðuna
}

/**
 * Keyrt þegar smellt er á "Leika".
 */
function handlePlay() {
    if (currentUser.pet.energy < 20) {
        alert(`${currentUser.pet.petName} er of þreyttur til að leika.`);
        return;
    }
    
    currentUser.pet.happiness += 20; // Verður glaðari
    currentUser.pet.energy -= 20;    // Leikur kostar orku
    currentUser.pet.hunger += 5;     // Leikur gerir svangan

    if (currentUser.pet.happiness > 100) currentUser.pet.happiness = 100;
    if (currentUser.pet.energy < 0) currentUser.pet.energy = 0;

    saveState();
    renderDashboard();
}

/**
 * Keyrt þegar smellt er á "Sofa" (Næsti dagur).
 * Hermir eftir því að tími líði.
 */
function handleSleep() {
    // Orka endurstillist
    currentUser.pet.energy = 100;
    
    // Dýrið verður svangara og leiðara yfir "nóttina"
    currentUser.pet.hunger += 25;
    currentUser.pet.happiness -= 15;

    // Pössum mörkin
    if (currentUser.pet.hunger > 100) currentUser.pet.hunger = 100;
    if (currentUser.pet.happiness < 0) currentUser.pet.happiness = 0;

    alert(`${currentUser.pet.petName} svaf vel og er fullur af orku fyrir nýjan dag!`);
    
    saveState();
    renderDashboard();
}

/**
 * Sér um útskráningu.
 */
function handleLogout() {
    // Fjarlægjum notandann úr sessionStorage
    sessionStorage.removeItem('petCurrentUser');
    // Sendum notanda aftur á innskráningarsíðu
    window.location.href = 'index.html';
}

/**
 * Vistar breytta stöðu 'currentUser' í bæði
 * sessionStorage (fyrir þennan flipa) og
 * localStorage (fyrir "gagnagrunninn").
 */
function saveState() {
    // 1. Vista í sessionStorage (svo síðan virki ef hún endurhleðst)
    sessionStorage.setItem('petCurrentUser', JSON.stringify(currentUser));

    // 2. Vista í localStorage ("gagnagrunninn")
    // Finnum index notandans í aðal 'users' fylkinu
    const userIndex = users.findIndex(user => user.username === currentUser.username);
    
    if (userIndex !== -1) { // Ef notandinn finnst
        users[userIndex] = currentUser; // Uppfærum hann í fylkinu
        localStorage.setItem('petUsers', JSON.stringify(users)); // Vistum allt fylkið aftur
    }
}
