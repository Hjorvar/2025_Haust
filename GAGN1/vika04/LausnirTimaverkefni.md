````markdown
# Lausnir á Stöðlunarverkefnum (Vika 4)

---

### Lausn á Dæmi 1: Employees on Projects

#### Greining á Vandamálum:
Upprunalega taflan, `project_assignments`, er með samsettan frumlykil (`project_id`, `employee_id`). Hönnunin þjáist af alvarlegu offramboði gagna (*data redundancy*) sem leiðir til þekktra frávika (*anomalies*):

1.  **Innsetningarfrávik (Insertion Anomaly):** Ekki er hægt að skrá nýtt verkefni nema að minnsta kosti einn starfsmaður sé skráður á það, því `employee_id` er hluti af frumlyklinum.
2.  **Uppfærslufrávik (Update Anomaly):** Ef verkefni skiptir um nafn (`project_name`) eða ef starfsmaður skiptir um deild (`employee_department`) þarf að uppfæra upplýsingarnar í mörgum röðum. Ef gleymist að uppfæra eina röð verða gögnin ósamkvæm.
3.  **Eyðingarfrávik (Deletion Anomaly):** Ef síðasti starfsmaðurinn er fjarlægður úr verkefni eyðist röðin og þar með allar upplýsingar um verkefnið sjálft, svo sem nafn þess og fjárhagsáætlun.

Vandamálið er brot á **annarri staðalformi (2NF)**. Dálkar eins og `project_name` eru aðeins háðir `project_id` og dálkar eins og `employee_name` eru aðeins háðir `employee_id`. Þeir eru því háðir aðeins hluta af frumlyklinum, sem kallast hlutaháð (*partial dependency*).

#### Stöðluð Hönnun (3NF):
Til að laga þetta þarf að brjóta töfluna upp í þrjár aðskildar töflur: eina fyrir verkefni, eina fyrir starfsmenn og eina samskeytatöflu (*junction table*) til að tengja þær saman.

-   `projects(project_id, project_name, project_budget)`
-   `employees(employee_id, employee_name, employee_department)`
-   `project_assignments(project_id, employee_id)`

#### CREATE kóði fyrir nýjar töflur:

```sql
-- Tafla fyrir verkefni
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    project_budget DECIMAL(10, 2)
);

-- Tafla fyrir starfsmenn
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_department VARCHAR(100)
);

-- Samskeytatafla sem tengir starfsmenn og verkefni
CREATE TABLE project_assignments (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);
````

#### Rökstuðningur:

Þessi nýja hönnun er í þriðju staðalformi (3NF). Hún leysir öll frávikin með því að tryggja að hver staðreynd sé aðeins geymd á einum stað. Upplýsingar um verkefni eru eingöngu í `projects` töflunni og upplýsingar um starfsmenn eru eingöngu í `employees` töflunni. `project_assignments` taflan geymir aðeins frumlyklana tvo til að skrá sambandið. Nú er hægt að stofna verkefni án starfsmanna og öfugt, og uppfærsla á nafni eða deild þarf aðeins að eiga sér stað á einum stað.

-----

### Lausn á Dæmi 2: Student Course Registration

#### Greining á Vandamálum:

Taflan `course_enrollments` brýtur í bága við **fyrstu staðalform (1NF)**. Ástæðan er sú að dálkurinn `enrolled_courses` inniheldur ekki atómísk gildi; hann geymir lista af mörgum gildum í einum reit. Þetta veldur mörgum vandamálum:

  - **Erfitt að leita:** Það er flókið og óskilvirkt að leita að öllum nemendum í ákveðnu námskeiði með SQL.
  - **Erfitt að uppfæra:** Ef námskeiðsnúmer breytist þarf að framkvæma flókna textaleit og -breytingu í mörgum röðum.
  - **Engin heilleikakvilla:** Ekki er hægt að nota erlendan lykil til að tryggja að námskeiðsnúmerin séu til í raun og veru.

#### Stöðluð Hönnun (3NF):

Lausnin er að brjóta þetta upp í þrjár töflur sem mynda tvö one-to-many sambönd í gegnum samskeytatöflu. Þetta er rétta leiðin til að útfæra many-to-many samband milli nemenda og námskeiða.

  - `students(student_id, student_name, email)`
  - `courses(course_id, course_name)`
  - `enrollments(student_id, course_id)`

#### CREATE kóði fyrir nýjar töflur:

```sql
-- Tafla fyrir nemendur
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Tafla fyrir námskeið
CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY, -- Using VARCHAR for course codes like 'CS101'
    course_name VARCHAR(255) NOT NULL
);

-- Samskeytatafla fyrir skráningar
CREATE TABLE enrollments (
    student_id INT,
    course_id VARCHAR(10),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE RESTRICT
);
```

#### Rökstuðningur:

Með þessari hönnun er hvert gagn atómískt og geymt í viðeigandi töflu. Hver skráning nemanda í námskeið er nú sérstök röð í `enrollments` töflunni. Það er nú einfalt að finna alla nemendur í námskeiði með `JOIN` fyrirspurn og uppfærsla á nafni námskeiðs þarf aðeins að gerast á einum stað í `courses` töflunni. Gagnaintegritet er tryggt með erlendum lyklum.

-----

### Lausn á Dæmi 3: Web Store Orders

#### Greining á Vandamálum:

Þetta er skýrt dæmi um brot á **annarri staðalformi (2NF)**. Frumlykillinn er samsettur úr (`order_id`, `product_id`). Vandamálið er að dálkarnir `product_name` og `price_per_item` eru ekki háðir öllum lyklinum. Þeir eru aðeins háðir `product_id`. Þetta er hlutaháð (*partial dependency*) og veldur:

  - **Innsetningarfráviki:** Ekki er hægt að bæta nýrri vöru við kerfið nema hún sé hluti af pöntun.
  - **Uppfærslufráviki:** Ef nafn vöru breytist þarf að uppfæra það í öllum pöntunarlínum þar sem varan kemur fyrir, sem er uppskrift að ósamkvæmni.

#### Stöðluð Hönnun (3NF):

Við leysum þetta með því að skipta töflunni í tvennt:

  - `products(product_id, product_name, current_price)`
  - `order_lines(order_id, product_id, quantity, price_at_purchase)`

#### CREATE kóði fyrir nýjar töflur:

```sql
-- Tafla fyrir vörur
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    current_price DECIMAL(8, 2) NOT NULL
);

-- Tafla fyrir pöntunarlínur
CREATE TABLE order_lines (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(8, 2) NOT NULL, -- Storing the price at the time of order
    PRIMARY KEY (order_id, product_id),
    -- Assuming an 'orders' table exists: FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);
```

#### Rökstuðningur:

Nú eru upplýsingar um vörur geymdar á einum stað í `products` töflunni. `order_lines` taflan inniheldur aðeins upplýsingar sem eru háðar bæði pöntun og vöru (magn) og geymir afrit af verðinu eins og það var þegar pöntunin var gerð. Þetta uppfyllir minnisregluna: "Every non-key attribute must provide a fact about... **the whole key**...".

-----

### Lausn á Dæmi 4: Instructor Directory

#### Greining á Vandamálum:

Þessi tafla er í 2NF (þar sem hún hefur ekki samsettan frumlykil) en brýtur í bága við **þriðju staðalform (3NF)**. Ástæðan er sú að hún inniheldur yfirfærsluháð (*transitive dependency*). Frumlykillinn er `instructor_id`. Við höfum eftirfarandi háð:
`instructor_id` → `department_name`
`department_name` → `department_head`
Hér ákvarðar dálkur sem ekki er lykill (`department_name`) annan dálk sem ekki er lykill (`department_head`). Þetta veldur:

  - **Uppfærslufráviki:** Ef deild fær nýjan deildarstjóra þarf að uppfæra `department_head` í röð hvers einasta kennara í þeirri deild.
  - **Eyðingarfráviki:** Ef síðasti kennarinn yfirgefur deild glatast allar upplýsingar um deildina, þar með talið hver stýrði henni.

#### Stöðluð Hönnun (3NF):

Við skiptum töflunni í tvennt til að fjarlægja yfirfærsluháðið:

  - `departments(department_name, department_head)`
  - `instructors(instructor_id, instructor_name, department_name)`

#### CREATE kóði fyrir nýjar töflur:

```sql
-- Tafla fyrir deildir
CREATE TABLE departments (
    department_name VARCHAR(150) PRIMARY KEY,
    department_head VARCHAR(100)
);

-- Tafla fyrir kennara
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    instructor_name VARCHAR(100) NOT NULL,
    department_name VARCHAR(150),
    FOREIGN KEY (department_name) REFERENCES departments(department_name) ON DELETE SET NULL
);
```

#### Rökstuðningur:

Núna eru upplýsingar um deildir (nafn og stjórnandi) aðeins geymdar á einum stað. `instructors` taflan vísar aðeins í deildina með erlendum lykli. Þetta uppfyllir minnisregluna: "...and **nothing but the key**.". Staðreyndir um deildina eru nú í deildartöflunni, ekki í kennaratöflunni.

-----

### Lausn á Dæmi 5: Library Loans

#### Greining á Vandamálum:

Þessi tafla, `loans_unnormalized`, þjáist af bæði offramboði og yfirfærsluháði, og brýtur því í bága við bæði 2NF og 3NF (þótt tæknilega séð sé það 3NF sem er brotið þar sem lykillinn er einfaldur).

1.  **Offramboð:** `member_name` og `member_address` eru endurtekin fyrir hvert einasta lán sem sami lánþeginn tekur. Þetta veldur uppfærslu- og innsetningarfrávikum.
2.  **Yfirfærsluháð (Transitive Dependency):** Við höfum keðjuna `loan_id` → `isbn` → `book_title`. `book_title` er staðreynd um bókina (`isbn`), ekki um lánið (`loan_id`).

#### Stöðluð Hönnun (3NF):

Við þurfum þrjár aðskildar töflur til að geyma upplýsingar um hverja einingu (*entity*) fyrir sig.

  - `books(isbn, book_title)`
  - `members(member_id, member_name, member_address)`
  - `loans(loan_id, isbn, member_id, loan_date)`

#### CREATE kóði fyrir nýjar töflur:

```sql
-- Tafla fyrir bækur
CREATE TABLE books (
    isbn VARCHAR(13) PRIMARY KEY,
    book_title VARCHAR(255) NOT NULL
);

-- Tafla fyrir lánþega
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    member_address VARCHAR(255)
);

-- Tafla fyrir útlán
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    isbn VARCHAR(13) NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    FOREIGN KEY (isbn) REFERENCES books(isbn) ON DELETE RESTRICT,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
```

#### Rökstuðningur:

Með því að aðskilja gögnin í þrjár töflur er hver staðreynd nú geymd nákvæmlega einu sinni. `loans` taflan virkar sem tenging milli `members` og `books` og inniheldur aðeins gögn sem eiga við lánið sjálft (eins og `loan_date`). Þetta útilokar offramboð og leysir öll frávikin. Ef lánþegi flytur þarf aðeins að uppfæra heimilisfangið á einum stað í `members` töflunni. Hönnunin fylgir nú stöðlunarreglum að fullu.

```
```