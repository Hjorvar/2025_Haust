const getUsers = () => {
    const usersJSON = localStorage.getItem('users');
    
    if (!usersJSON) {
        return [];
    }
    
    return JSON.parse(usersJSON);
};

const saveUsers = (usersArray) => {
    const usersJSON = JSON.stringify(usersArray);
    
    localStorage.setItem('users', usersJSON);
};

const handleRegister = (event) => {
    event.preventDefault(); 
    
    const form = event.target;
    const messageElement = document.querySelector('#message');
    messageElement.textContent = '';

    const usernameInput = form.querySelector('#reg-username');
    const passwordInput = form.querySelector('#reg-password');

    const username = usernameInput.value.trim();
    const password = passwordInput.value.trim();

    const users = getUsers();
    
    const userExists = 
        users.some(user => user.username === username);
    
    if (userExists) {
        messageElement.textContent = 'Notandanafn er þegar frátekið.';
        return; 
    }

    const newUser = {
        username: username,
        password: password
    };

    users.push(newUser);
    
    saveUsers(users);

    alert(`Nýskráning tókst fyrir ${username}!`);
    window.location.href = 'login.html';
};

const handleLogin = (event) => {
    event.preventDefault(); 
    
    const form = event.target;
    const messageElement = document.querySelector('#message');
    messageElement.textContent = '';
    
    const usernameInput = form.querySelector('#login-username');
    const passwordInput = form.querySelector('#login-password');
    
    const username = usernameInput.value.trim();
    const password = passwordInput.value.trim();

    const users = getUsers();
    
    const foundUser = users.find(user => user.username === username && user.password === password);

    if (foundUser) {
        alert(`Velkomin/n, ${username}! Innskráning tókst.`);
        window.location.href = 'velkomin.html'; 
    } else {
        messageElement.textContent = 'Rangt notandanafn eða lykilorð.';
    }
};


const registerForm = document.querySelector('#register-form');
const loginForm = document.querySelector('#login-form');

if (registerForm) {
    registerForm.addEventListener('submit', handleRegister);
}

if (loginForm) {
    loginForm.addEventListener('submit', handleLogin);
}