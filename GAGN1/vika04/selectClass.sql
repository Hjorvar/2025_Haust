/*******************************************************************
** Sýnidæmi: Fyrirspurnir sem sýna kosti stöðlunar
** Gagnasafnsfræði 1 - 2025
**
** Lýsing: Þessi skrifta inniheldur SELECT fyrirspurnir sem sýna
** vandamálin í óstöðluðum töflum (0NF, 1NF, 2NF) og kosti
** vel hannaðs skema (3NF).
** Keyrið þessa skriftu EFTIR að búið er að keyra create/insert
** skriftuna.
*******************************************************************/

-- =================================================================
-- SKREF 0: ÓSTÖÐLUÐ TAFLA (0NF) - VANDAMÁL MEÐ VINNSLU GAGNA
-- =================================================================

-- Fyrirspurn á 0NF töflu
-- Þetta er óskilvirkt, viðkvæmt fyrir villum og treystir á textaleit.
SELECT pontun_id, vidskiptavinur_nafn, vorur_pantaðar
FROM vefverslun_pantanir_0nf
WHERE vorur_pantaðar LIKE '%P10%';

-- Útskýring fyrir nemendur:
-- Sjáið hversu frumstæð þessi aðferð er. Við erum að nota LIKE til að leita í texta.
-- Hvað ef einhver skrifaði 'p10' með litlum staf? Eða ef bil vantaði? Fyrirspurnin myndi bila.
-- Það er líka ómögulegt að gera útreikninga. Við getum ekki lagt saman heildarverð
-- pöntunar eða fundið meðalmagn. Þetta sýnir hvers vegna við þurfum atómísk gögn.


-- =================================================================
-- SKREF 1: FYRSTA STAÐALFORM (1NF) - VANDAMÁL MEÐ OFFRAMBOÐ
-- =================================================================

-- Fyrirspurn 1: Sýnir endurtekningu á upplýsingum um viðskiptavin.
SELECT pontun_id, vidskiptavinur_nafn, voruheiti
FROM pantanir_1nf
WHERE vidskiptavinur_id = 'V550';

-- Útskýring fyrir nemendur:
-- Takið eftir að nafn Jóns er endurtekið þrisvar sinnum. Ef hann breytir um nafn eða
-- ef við komumst að því að það var innsláttarvilla þyrftum við að uppfæra það á
-- mörgum stöðum. Þetta er uppfærslufrávik (update anomaly) í hnotskurn.


-- Fyrirspurn 2: Sýnir endurtekningu á upplýsingum um vöru.
SELECT pontun_id, voruheiti, einingaverd
FROM pantanir_1nf
WHERE vara_id = 'P10';

-- Útskýring fyrir nemendur:
-- Sama vandamál hér. Nafn og verð vörunnar er endurtekið. Ef verðið á "Hleðslubanka"
-- breytist, þarf að uppfæra það alls staðar þar sem varan kemur fyrir. Þetta er
-- óskilvirkt og hættulegt fyrir heilleika gagnanna.


-- =================================================================
-- SKREF 2: ANNAÐ STAÐALFORM (2NF) - VANDAMÁL MEÐ GEGNUMHÁÐ TENGSL
-- =================================================================

-- Fyrirspurn: Sýnir að upplýsingar um viðskiptavin eru enn endurteknar.
SELECT *
FROM pantanir_2nf
ORDER BY vidskiptavinur_id;

-- Útskýring fyrir nemendur:
-- Þótt taflan sé mun betri er nafn Jóns Jónssonar enn endurtekið (fyrir pöntun 101 og 103).
-- Ástæðan er sú að `vidskiptavinur_nafn` er staðreynd um `vidskiptavinur_id`, ekki um `pontun_id`.
-- Þetta er gegnumháð (transitive) tengsl. Við erum enn að blanda saman tveimur
-- hugtökum (pöntunum og viðskiptavinum) í eina töflu.


-- =================================================================
-- SKREF 3: ÞRIÐJA STAÐALFORM (3NF) - KRAFTUR VEL HANNAÐS SKEMA
-- =================================================================

-- Fyrirspurn 1: Sýnir hvernig JOIN sameinar gögn úr mörgum vel
-- skilgreindum töflum til að fá heildstæða sýn.
SELECT
    p.pontun_id,
    p.pontun_dagsetning,
    v.vidskiptavinur_nafn,
    vo.voruheiti,
    pl.magn,
    vo.einingaverdx
FROM pantanir_3nf p
JOIN vidskiptavinir_3nf v ON p.vidskiptavinur_id = v.vidskiptavinur_id
JOIN pontunarlinur_3nf pl ON p.pontun_id = pl.pontun_id
JOIN vorur_3nf vo ON pl.vara_id = vo.vara_id
WHERE p.pontun_id = 101;

-- Útskýring fyrir nemendur:
-- Hér sjáum við kraftinn í venslagagnagrunni. Hver tafla geymir aðeins sínar eigin
-- upplýsingar og við notum JOIN til að púsla þeim saman á öflugan hátt.
-- Engar endurtekningar, engin frávik. Ef við breytum nafni Jóns í `vidskiptavinir_3nf`
-- töflunni, þá uppfærist það sjálfkrafa í þessari fyrirspurn.


-- Fyrirspurn 2: Gerir útreikninga sem voru ómögulegir áður.
-- Reiknum heildarverð fyrir hverja pöntun.
SELECT
    pl.pontun_id,
    SUM(pl.magn * v.einingaverd) AS heildarverd_pontunar
FROM
    pontunarlinur_3nf pl
JOIN
    vorur_3nf v ON pl.vara_id = v.vara_id
GROUP BY
    pl.pontun_id
ORDER BY
    pl.pontun_id;

-- Útskýring fyrir nemendur:
-- Þessi fyrirspurn hefði verið ómöguleg í 0NF og mjög flókin í 1NF. Með 3NF
-- hönnuninni er hún einföld og rökrétt. Við sækjum magn úr einni töflu, verð úr
-- annarri, margföldum saman og notum svo SUM og GROUP BY til að fá heildarniðurstöðu
-- fyrir hverja pöntun. Þetta sýnir að vel stöðluð hönnun er ekki bara fræðileg
-- heldur er hún forsenda fyrir því að geta unnið með gögnin á sveigjanlegan
-- og öflugan hátt.