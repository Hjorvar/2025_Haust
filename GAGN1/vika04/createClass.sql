/*******************************************************************
** Sýnidæmi: Stöðlun (Normalization) úr 0NF í 3NF
** Gagnasafnsfræði 1 - 2025
**
** Lýsing: Þessi skrifta sýnir skref-fyrir-skref ferlið við að
** taka illa hannaða töflu og staðla hana yfir í 3. staðalform.
*******************************************************************/

-- =================================================================
-- SKREF 0: ÓSTÖÐLUÐ TAFLA (UNF / 0NF)
-- =================================================================
-- Við líkjum eftir óstaðlaðri töflu með því að geyma margar
-- upplýsingar í einum TEXT dálki. Þetta er mjög slæm hönnun og
-- er aðeins gert hér til sýnikennslu.
-- =================================================================

CREATE TABLE vefverslun_pantanir_0nf (
    pontun_id INT,
    pontun_dagsetning DATE,
    vidskiptavinur_id VARCHAR(10),
    vidskiptavinur_nafn VARCHAR(100),
    vorur_pantaðar TEXT -- Inniheldur lista af vörum, brýtur gegn 1NF
);

INSERT INTO vefverslun_pantanir_0nf (pontun_id, pontun_dagsetning, vidskiptavinur_id, vidskiptavinur_nafn, vorur_pantaðar) VALUES
(101, '2025-09-08', 'V550', 'Jón Jónsson', '(P10, 1, 5000kr), (P12, 2, 1500kr)'),
(102, '2025-09-08', 'V551', 'Gunna Gunnars', '(P10, 3, 5000kr)'),
(103, '2025-09-09', 'V550', 'Jón Jónsson', '(P11, 1, 3500kr)');


-- =================================================================
-- SKREF 1: FYRSTA STAÐALFORM (1NF)
-- =================================================================
-- Markmið: Fjarlægja endurteknar upplýsingar úr dálkum og tryggja
-- að öll gildi séu atómísk. Hver vara fær sína eigin röð.
-- Vandamál: Mikið offramboð (redundancy) og frávik (anomalies).
-- =================================================================

CREATE TABLE pantanir_1nf (
    pontun_id INT,
    pontun_dagsetning DATE,
    vidskiptavinur_id VARCHAR(10),
    vidskiptavinur_nafn VARCHAR(100),
    vara_id VARCHAR(10),
    magn INT,
    voruheiti VARCHAR(100),
    einingaverd INT,
    PRIMARY KEY (pontun_id, vara_id) -- Samsettur frumlykill
);

INSERT INTO pantanir_1nf (pontun_id, pontun_dagsetning, vidskiptavinur_id, vidskiptavinur_nafn, vara_id, magn, voruheiti, einingaverd) VALUES
(101, '2025-09-08', 'V550', 'Jón Jónsson', 'P10', 1, 'Hleðslubanki', 5000),
(101, '2025-09-08', 'V550', 'Jón Jónsson', 'P12', 2, 'Heyrnartól', 1500),
(102, '2025-09-08', 'V551', 'Gunna Gunnars', 'P10', 3, 'Hleðslubanki', 5000),
(103, '2025-09-09', 'V550', 'Jón Jónsson', 'P11', 1, 'Símahulstur', 3500);


-- =================================================================
-- SKREF 2: ANNAÐ STAÐALFORM (2NF)
-- =================================================================
-- Markmið: Fjarlægja hlutháð tengsl (partial dependencies).
-- Dálkar sem eru aðeins háðir hluta af samsetta lyklinum eru
-- færðir í eigin töflur.
-- Lausn: Brjótum 1NF töfluna upp í þrjár töflur.
-- =================================================================

-- Tafla fyrir pantanir
CREATE TABLE pantanir_2nf (
    pontun_id INT PRIMARY KEY,
    pontun_dagsetning DATE,
    vidskiptavinur_id VARCHAR(10),
    vidskiptavinur_nafn VARCHAR(100) -- Þessi dálkur veldur gegnumháðum tengslum (violates 3NF)
);

-- Tafla fyrir vörur
CREATE TABLE vorur_2nf (
    vara_id VARCHAR(10) PRIMARY KEY,
    voruheiti VARCHAR(100),
    einingaverd INT
);

-- Samskeytatafla (Junction table) fyrir pöntunarlínur
CREATE TABLE pontunarlinur_2nf (
    pontun_id INT REFERENCES pantanir_2nf(pontun_id),
    vara_id VARCHAR(10) REFERENCES vorur_2nf(vara_id),
    magn INT,
    PRIMARY KEY (pontun_id, vara_id)
);

-- Fyllum töflurnar með gögnum úr 1NF töflunni
INSERT INTO pantanir_2nf (pontun_id, pontun_dagsetning, vidskiptavinur_id, vidskiptavinur_nafn) VALUES
(101, '2025-09-08', 'V550', 'Jón Jónsson'),
(102, '2025-09-08', 'V551', 'Gunna Gunnars'),
(103, '2025-09-09', 'V550', 'Jón Jónsson');

INSERT INTO vorur_2nf (vara_id, voruheiti, einingaverd) VALUES
('P10', 'Hleðslubanki', 5000),
('P11', 'Símahulstur', 3500),
('P12', 'Heyrnartól', 1500);

INSERT INTO pontunarlinur_2nf (pontun_id, vara_id, magn) VALUES
(101, 'P10', 1),
(101, 'P12', 2),
(102, 'P10', 3),
(103, 'P11', 1);


-- =================================================================
-- SKREF 3: ÞRIÐJA STAÐALFORM (3NF)
-- =================================================================
-- Markmið: Fjarlægja gegnumháð tengsl (transitive dependencies).
-- Dálkur sem er háður öðrum dálki (sem er ekki lykill) er færður
-- í sína eigin töflu.
-- Lausn: Brjótum 'pantanir_2nf' töfluna upp til að aðskilja
-- upplýsingar um viðskiptavini.
-- =================================================================

-- Tafla fyrir viðskiptavini
CREATE TABLE vidskiptavinir_3nf (
    vidskiptavinur_id VARCHAR(10) PRIMARY KEY,
    vidskiptavinur_nafn VARCHAR(100)
);

-- Tafla fyrir pantanir, nú án upplýsinga um nafn viðskiptavinar
CREATE TABLE pantanir_3nf (
    pontun_id INT PRIMARY KEY,
    pontun_dagsetning DATE,
    vidskiptavinur_id VARCHAR(10) REFERENCES vidskiptavinir_3nf(vidskiptavinur_id)
);

-- Tafla fyrir vörur (óbreytt frá 2NF, bara endurnefnd)
CREATE TABLE vorur_3nf (
    vara_id VARCHAR(10) PRIMARY KEY,
    voruheiti VARCHAR(100),
    einingaverd INT
);

-- Samskeytatafla (óbreytt frá 2NF, bara endurnefnd)
CREATE TABLE pontunarlinur_3nf (
    pontun_id INT REFERENCES pantanir_3nf(pontun_id),
    vara_id VARCHAR(10) REFERENCES vorur_3nf(vara_id),
    magn INT,
    PRIMARY KEY (pontun_id, vara_id)
);

-- Fyllum lokatöflurnar með gögnum
INSERT INTO vidskiptavinir_3nf (vidskiptavinur_id, vidskiptavinur_nafn) VALUES
('V550', 'Jón Jónsson'),
('V551', 'Gunna Gunnars');

INSERT INTO pantanir_3nf (pontun_id, pontun_dagsetning, vidskiptavinur_id) VALUES
(101, '2025-09-08', 'V550'),
(102, '2025-09-08', 'V551'),
(103, '2025-09-09', 'V550');

INSERT INTO vorur_3nf (vara_id, voruheiti, einingaverd) VALUES
('P10', 'Hleðslubanki', 5000),
('P11', 'Símahulstur', 3500),
('P12', 'Heyrnartól', 1500);

INSERT INTO pontunarlinur_3nf (pontun_id, vara_id, magn) VALUES
(101, 'P10', 1),
(101, 'P12', 2),
(102, 'P10', 3),
(103, 'P11', 1);