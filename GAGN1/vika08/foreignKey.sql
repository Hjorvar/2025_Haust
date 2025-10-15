ALTER TABLE books
ADD CONSTRAINT fk_author
FOREIGN KEY (id_author)
REFERENCES authors (id);

