CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    region VARCHAR(255),
    idSponsor INTEGER,
    country VARCHAR(255)
);

