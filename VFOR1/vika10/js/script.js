function checkAnswers() {
    // Rétt svör (við leyfum nokkrar útgáfur)
    const correctAnswers = {
        q1: ["bolluvönd", "bolluvöndur", "vönd"],
        q2: ["saltkjöt og baunir", "saltkjöt", "baunasúpa"],
        q3: ["syngja", "syngja lög"]
    };

    // Svör notanda (umbreytt í lágstafi til að vera ekki hástafanæmt)
    const userAnswers = {
        q1: document.getElementById('q1').value.toLowerCase().trim(),
        q2: document.getElementById('q2').value.toLowerCase().trim(),
        q3: document.getElementById('q3').value.toLowerCase().trim()
    };

    const resultsDiv = document.getElementById('quiz-results');
    resultsDiv.innerHTML = ''; // Hreinsum fyrri niðurstöður

    // Förum yfir hverja spurningu og birtum niðurstöðu
    for (const question in correctAnswers) {
        const resultP = document.createElement('p');
        const userAnswer = userAnswers[question];
        const possibleAnswers = correctAnswers[question];

        // Athugum hvort svar notanda sé í listanum yfir rétt svör
        if (possibleAnswers.includes(userAnswer)) {
            resultP.textContent = `Spurning ${question.slice(1)}: Rétt!`;
            resultP.className = 'correct';
        } else {
            resultP.textContent = `Spurning ${question.slice(1)}: Rangt. Rétt svar gæti verið t.d. "${possibleAnswers[0]}".`;
            resultP.className = 'incorrect';
        }
        resultsDiv.appendChild(resultP);
    }
}