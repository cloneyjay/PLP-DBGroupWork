create database if not exists BookStoreDB;
use BookStoreDB;

-- Book-related tables
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    publisher_id INT NOT NULL,
    book_language_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    publication_year YEAR NOT NULL
);

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT
);

CREATE TABLE book_author (
    unique_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE book_languages (
    book_language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE
);

-- Customer and Address related tables
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    zipcode VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    address_status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

-- Order related tables
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    description TEXT
);

CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE cust_order (
    cust_order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

CREATE TABLE order_line (
    orderline_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cust_order_id) REFERENCES cust_order(cust_order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- New order history table for tracking status changes
CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_order_id INT NOT NULL,
    order_status_id INT NOT NULL,
    status_changed_date DATETIME NOT NULL,
    FOREIGN KEY (cust_order_id) REFERENCES cust_order(cust_order_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

-- Sample Data Insertions
-- Publishers
INSERT INTO publishers (publisher_name, email, phone) VALUES 
    ('Penguin Random House', 'contact@penguin.com', '123456789'),
    ('HarperCollins', 'info@harpercollins.com', '987654321');

-- Book Languages
INSERT INTO book_languages (language_name) VALUES 
    ('English'),
    ('French'),
    ('Spanish');

-- Authors
INSERT INTO authors (first_name, last_name, biography) VALUES 
    ('J.K.', 'Rowling', 'British author, best known for the Harry Potter series.'),
    ('George', 'Orwell', 'Author of 1984 and Animal Farm'),
    ('Jane', 'Austen', 'Author of Pride and Prejudice');

-- Books
INSERT INTO books (title, isbn, publisher_id, book_language_id, price, stock, publication_year) VALUES 
    ('1984', '9780451524935', 1, 1, 15.99, 50, 1949),
    ('Pride and Prejudice', '9780141439518', 2, 1, 12.99, 30, 1813);

-- Book Authors
INSERT INTO book_author (book_id, author_id) VALUES 
    (1, 2),  -- Orwell - 1984
    (2, 3);  -- Austen - Pride and Prejudice

-- Countries
INSERT INTO country (country_name) VALUES 
    ('USA'),
    ('UK'),
    ('South Africa');

-- Address Status
INSERT INTO address_status (status) VALUES 
    ('Current'),
    ('Old');

-- Addresses
INSERT INTO address (street, city, state, zipcode, country_id) VALUES 
    ('123 Main St', 'New York', 'NY', '10001', 1),
    ('221B Baker St', 'London', 'England', 'NW1 6XE', 2);

-- Customers (combining both sets of customer data)
INSERT INTO customers (first_name, last_name, email, phone) VALUES 
    ('Melita', 'Letsoalo', 'melitaletsoalo@gmail.com', '016-456-7890'),
    ('Khalipa', 'Baba', 'khalipa.baba@gmail.com', '021-567-8901'),
    ('James', 'Sangatia', 'jamessangatia445@gmail.com', '013-678-9012'),
    ('Alice', 'Johnson', 'alice@example.com', '555-1234'),
    ('Bob', 'Smith', 'bob@example.com', '555-5678');

-- Customer Addresses
INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES 
    (4, 1, 1),  -- Alice's address
    (5, 2, 1);  -- Bob's address

-- Order Status
INSERT INTO order_status (status_name) VALUES 
    ('Pending'),
    ('Shipped'),
    ('Delivered'),
    ('Cancelled');

-- Shipping Methods
INSERT INTO shipping_method (method_name, cost, description) VALUES 
    ('Standard', 5.99, '3-5 business days'),
    ('Express', 15.99, '1-2 business days');

-- Sample Orders
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, order_status_id, total_amount) VALUES 
    (4, '2024-04-10', 1, 1, 15.99),
    (5, '2024-04-11', 2, 2, 28.98);

-- Order Lines
INSERT INTO order_line (cust_order_id, book_id, quantity, unit_price) VALUES 
    (1, 1, 1, 15.99),
    (2, 1, 1, 15.99),
    (2, 2, 1, 12.99);

-- Order History
INSERT INTO order_history (cust_order_id, order_status_id, status_changed_date) VALUES 
    (1, 1, '2024-04-10'),
    (2, 1, '2024-04-11'),
    (2, 2, '2024-04-12');