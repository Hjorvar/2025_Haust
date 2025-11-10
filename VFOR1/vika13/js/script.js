const employees = [
    {
        id: 1,
        name: "Anna Gunnarsdóttir",
        department: "Development",
        status: "Permanent"
    },
    {
        id: 2,
        name: "Björn Pálsson",
        department: "Sales",
        status: "Temporary"
    },
    {
        id: 3,
        name: "Katrín Jónsdóttir",
        department: "Development",
        status: "Permanent"
    },
    {
        id: 4,
        name: "Davíð Karls",
        department: "Sales",
        status: "Permanent"
    }
];

const listContainer = document.querySelector("#listiContainer");
const showAllBtn = document.querySelector("#synaAllaBtn");
const showDevelopmentBtn = document.querySelector("#synaThrounBtn");
const showSalesBtn = document.querySelector("#synaSoluBtn");

const renderList = (list) => {
    listContainer.innerHTML = '';

    list.forEach(employee => {
        
        let extraClass = '';
        if (employee.department === 'Development') {
            extraClass = 'kort-throun';
        }

        const cardHtml = `
            <article class="starfsmanna-kort ${extraClass}">
                <h3>${employee.name}</h3>
                <p>Department: ${employee.department}</p>
                <p>Status: ${employee.status}</p>
            </article>
        `;

        listContainer.insertAdjacentHTML('beforeend', cardHtml);
    });
};

showAllBtn.addEventListener('click', () => {
    renderList(employees);
});

showDevelopmentBtn.addEventListener('click', () => {
    const developmentDepartment = employees.filter(e => e.department === 'Development');
    renderList(developmentDepartment);
});

showSalesBtn.addEventListener('click', () => {
    const salesDepartment = employees.filter(e => e.department === 'Sales');
    renderList(salesDepartment);
});

renderList(employees);