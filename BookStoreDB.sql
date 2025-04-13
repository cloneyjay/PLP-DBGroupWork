create database if not exists BookStoreDB;
CREATE TABLE books (
    title VARCHAR(255) NOT NULL,          -- Book title
    isbn VARCHAR(13) NOT NULL UNIQUE,    -- ISBN (unique identifier for the book)
    publisher_id INT NOT NULL,           -- Foreign key linking to the publishers table
    book_language_id INT NOT NULL,       -- Foreign key linking to the languages table
    price DECIMAL(10, 2) NOT NULL,       -- Price of the book
    stock INT NOT NULL,                  -- Number of copies available
    publication_year YEAR NOT NULL       -- Year of publication
); 
 CREATE TABLE book_author (
    unique_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each entry
    book_id INT NOT NULL,                      -- Foreign key linking to the books table
    author_id INT NOT NULL,                    -- Foreign key linking to the authors table
    FOREIGN KEY (book_id) REFERENCES books(isbn) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each author
    first_name VARCHAR(50) NOT NULL,           -- Author's first name
    last_name VARCHAR(50) NOT NULL,            -- Author's last name
    biography TEXT                             -- A text column for the author's biography
);
INSERT INTO authors (first_name, last_name, biography)
VALUES 
    ('J.K.', 'Rowling', 'British author, best known for the Harry Potter series.'),
    ('George', 'Orwell', 'English novelist and essayist, known for works like 1984 and Animal Farm.'),
    ('Jane', 'Austen', 'English novelist known for her romantic fiction like Pride and Prejudice.');
    CREATE TABLE book_languages (
    book_language_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each language
    language_name VARCHAR(100) NOT NULL UNIQUE       -- Name of the language (e.g., English, French, etc.)
);
INSERT INTO book_languages (language_name)
VALUES 
    ('English'),
    ('French'),
    ('Spanish');
    CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each customer
    first_name VARCHAR(50) NOT NULL,             -- Customer's first name
    last_name VARCHAR(50) NOT NULL,              -- Customer's last name
    email VARCHAR(100) UNIQUE NOT NULL,          -- Customer's email address (unique)
    phone VARCHAR(15) UNIQUE NOT NULL            -- Customer's phone number (unique)
);
INSERT INTO customers (first_name, last_name, email, phone)
VALUES
    ('Melita', 'Letsoalo', 'melitaletsoalo@gmailcom', '016-456-7890'),
    ('Khalipa', '', 'khalipa.baba@gmail.com', '021-567-8901'),
    ('James', '', 'jamessangatia445@gmail.com', '013-678-9012');
    CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique ID for each publisher
    publisher_name VARCHAR(255) NOT NULL,         -- Publisher's name
    email VARCHAR(100) UNIQUE,                    -- Publisher's email (unique)
    phone VARCHAR(15) UNIQUE                      -- Publisher's phone number (unique)
);