
function runFizzBuzz(limit) {

    for (let i = 1; i <= limit; i++) {

        if (i % 3 === 0 && i % 5 === 0) {
            console.log("FizzBuzz");
        } else if (i % 3 === 0) {
            console.log("Fizz");
        } else if (i % 5 === 0) {
            console.log("Buzz");
        } else {
            console.log(i);
        }
    }
}

function generateGreeting(name) {
    const greeting = "Halló, " + name + "! Velkomin(n) í Viku 10.";
    return greeting; 
}


const myGreeting = generateGreeting("Nemandi");
console.log(myGreeting);

console.log("--- Byrja FizzBuzz áskorun upp að 30 ---");
runFizzBuzz(30);