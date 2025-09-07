-- Tafla 1: artists
-- Inniheldur aðeins upplýsingar um flytjendur.
-- Þessi tafla verður að vera til áður en við búum til 'albums' því 'albums' vísar í hana.
CREATE TABLE artists (
    -- SERIAL er PostgreSQL gagnatýpa sem býr til sjálfhækkandi heiltölu.
    -- Fullkomið fyrir frumlykil (surrogate key).
    artist_id SERIAL PRIMARY KEY,

    -- VARCHAR(255) geymir texta af breytilegri lengd, að hámarki 255 stafir.
    -- NOT NULL þýðir að þessi dálkur má aldrei vera tómur.
    artist_name VARCHAR(255) NOT NULL
);


-- Tafla 2: albums
-- Inniheldur upplýsingar um plötur. Hver plata tilheyrir einum flytjanda.
CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    album_title VARCHAR(255) NOT NULL,
    release_year INT,

    -- Þetta verður framandi lykill (Foreign Key) sem vísar í 'artists' töfluna.
    -- Hann verður að vera af sömu gagnatýpu og lykillinn sem hann vísar í (artist_id er heiltala).
    artist_id INT NOT NULL,

    -- Hér skilgreinum við formlega sambandið á milli 'albums' og 'artists'.
    -- 'fk_album_artist' er nafn sem við gefum þessari heilleikareglu.
    CONSTRAINT fk_album_artist
        FOREIGN KEY (artist_id) -- Dálkurinn í ÞESSARI töflu
        REFERENCES artists (artist_id) -- Vísar í 'artists' töfluna og 'artist_id' dálkinn þar
        ON DELETE RESTRICT -- KEMUR Í VEG FYRIR að flytjanda sé eytt ef hann á enn plötur skráðar.
);


-- Tafla 3: tracks
-- Inniheldur upplýsingar um einstök lög. Hvert lag tilheyrir einni plötu.
CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    track_title VARCHAR(255) NOT NULL,
    duration_seconds INT,

    -- Framandi lykill sem vísar í 'albums' töfluna.
    album_id INT NOT NULL,

    CONSTRAINT fk_track_album
        FOREIGN KEY (album_id)
        REFERENCES albums (album_id)
        -- ON DELETE CASCADE: Ef plötu er eytt, þá eyðast öll lög á henni líka.
        -- Þetta er rökrétt, því lag getur ekki verið til án plötu.
        ON DELETE CASCADE
);

-- Tafla 4: genres
-- Þessi tafla geymir einfaldlega lista yfir allar mögulegar tónlistarstefnur.
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL UNIQUE
);


-- Skref 2: Búa til samskeytitöfluna sjálfa.
-- Hlutverk þessarar töflu er EINGÖNGU að tengja saman 'tracks' og 'genres'.
-- Hún inniheldur enga aðra lýsandi dálka.
CREATE TABLE track_genres (
    -- Þessi tafla inniheldur tvo dálka, sem báðir eru framandi lyklar.
    track_id INT NOT NULL,
    genre_id INT NOT NULL,

    -- SKILGREINING Á SAMSETTUM FRUMLYKLI (COMPOSITE PRIMARY KEY)
    -- Frumlykillinn er samsetning beggja dálkanna.
    -- Þetta tryggir tvennt:
    -- 1. Hver lína er einstök.
    -- 2. Sama lagi er ekki hægt að tengja við sömu tónlistarstefnu oftar en einu sinni.
    CONSTRAINT pk_track_genres PRIMARY KEY (track_id, genre_id),

    -- SKILGREINING Á FRAMANDI LYKLUM
    -- Tenging við 'tracks' töfluna.
    CONSTRAINT fk_track
        FOREIGN KEY (track_id)
        REFERENCES tracks (track_id)
        ON DELETE CASCADE, -- Ef lagi er eytt, eyðist þessi tenging líka.

    -- Tenging við 'genres' töfluna.
    CONSTRAINT fk_genre
        FOREIGN KEY (genre_id)
        REFERENCES genres (genre_id)
        ON DELETE CASCADE -- Ef tónlistarstefnu er eytt, eyðast allar tengingar við hana.
);
