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
    publication_year YEAR NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
    FOREIGN KEY (book_language_id) REFERENCES book_languages(book_language_id)
);

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT
);

CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
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
    cust_order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (cust_order_id, book_id),
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
    ('Pride and Prejudice', '9780141439518', 2, 1, 12.99, 30, 1913);

-- Book Authors
INSERT INTO book_author (book_id, author_id) VALUES 
    (3, 2),  -- Orwell - 1984
    (4, 3);  -- Austen - Pride and Prejudice
    

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
    (1, 3, 1, 15.99),
    (2, 3, 1, 15.99),
    (2, 4, 1, 12.99);

-- Order History
INSERT INTO order_history (cust_order_id, order_status_id, status_changed_date) VALUES 
    (1, 1, '2024-04-10'),
    (2, 1, '2024-04-11'),
    (2, 2, '2024-04-12');
    
-- creating users and granting priviledges
CREATE USER 'cloneyjay'@'%' IDENTIFIED BY 'cloneyjay@2025';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'cloneyjay'@'%' WITH GRANT OPTION;

CREATE USER 'Khalipa-B'@'%' IDENTIFIED BY 'Khalipa-B@2025';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'Khalipa-B'@'%' WITH GRANT OPTION;

CREATE USER 'Thukxin'@'%' IDENTIFIED BY 'Thukxin@2025';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'Thukxin'@'%' WITH GRANT OPTION;

-- flush priviledges
FLUSH PRIVILEGES; 


-- ========================================
-- 📚 BookstoreDB Test Queries (READ/WRITE)
-- ========================================

-- ======= READ QUERIES =======

-- 1. List all books with their authors and publisher
SELECT 
    b.title,
    a.first_name AS author_first_name,
    a.last_name AS author_last_name,
    p.publisher_name AS publisher
FROM books b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN authors a ON ba.author_id = a.author_id
JOIN publishers p ON b.publisher_id = p.publisher_id;

-- 2. List all customers with their addresses and country
SELECT 
    c.first_name,
    c.last_name,
    a.street,
    a.city,
    cn.country_name,
    s.status AS address_status
FROM customers c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN address_status s ON ca.address_status_id = s.address_status_id
JOIN country cn ON a.country_id = cn.country_id;

-- 3. Show all orders with customer info and order status
SELECT 
    o.cust_order_id,
    c.first_name,
    c.last_name,
    os.status_name AS order_status,
    o.order_date
FROM cust_order o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_status os ON o.order_status_id = os.order_status_id;

-- 4. List all books in a specific order
SELECT 
    ol.cust_order_id,
    b.title,
    ol.quantity,
    ol.unit_price
FROM order_line ol
JOIN books b ON ol.book_id = b.book_id
WHERE ol.cust_order_id = 1;

-- 5. Show order history
SELECT 
    oh.cust_order_id,
    os.status_name,
    oh.status_changed_date
FROM order_history oh
JOIN order_status os ON oh.order_status_id = os.order_status_id
ORDER BY oh.status_changed_date DESC;


-- ======= WRITE QUERIES =======

-- 6. Insert a new customer and assign an address
INSERT INTO customers (first_name, last_name, email, phone) 
VALUES ('Alice', 'Smith', 'alice.smith@example.com', '0723344556');

INSERT INTO address (street, city, zipcode, country_id) 
VALUES ('123 Blue St', 'Nairobi', '00100', 1);


-- 7. Update a book's stock quantity
UPDATE books
SET stock = stock - 1
WHERE book_id = 2;


-- 8. Insert a new order and its items
INSERT INTO cust_order (customer_id, order_status_id, order_date, shipping_method_id)
VALUES (1, 1, NOW(), 1);

-- 9. Insert into order history
INSERT INTO order_history (cust_order_id, order_status_id, status_changed_date)
VALUES (2, 2, NOW());
