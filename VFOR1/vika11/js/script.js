console.log('Script loaded successfully!');

const generateGreeting = (name) => {
  return `Hello, ${name}! Welcome to my portfolio.`;
};

const myGreeting = generateGreeting("Kennari");
console.log(myGreeting);

const mySkills = [
                    "HTML", 
                    "CSS", 
                    "Git", 
                    "JavaScript"
                ];

const aboutMe = {
  name: "Alex Doe",
  city: "Reykjavík",
  currentRole: "Aspiring Web Developer"
};

console.log("My skills are:", mySkills);
console.log("A little about me:", aboutMe);
console.log("My first skill is:", mySkills[0]);
console.log("My name is:", aboutMe.name);