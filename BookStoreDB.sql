create database if not exists BookStoreDB;
use BookStoreDB;

-- order_history table
 CREATE TABLE order_history (
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_order_id INT NOT NULL,
    order_status_id INT NOT NULL,
    status_changed_date DATETIME NOT NULL,
);

 --  shipping_method table
 CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    description TEXT,
);

-- order_status table
 CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Book Languages
INSERT INTO Book_Language (language_name) VALUES ('English');
INSERT INTO Book_Language (language_name) VALUES ('French');

-- Publishers
INSERT INTO Publisher (publisher_name, email, phone) VALUES ('Penguin Random House', 'contact@penguin.com', '123456789');
INSERT INTO Publisher (publisher_name, email, phone) VALUES ('HarperCollins', 'info@harpercollins.com', '987654321');

-- Authors
INSERT INTO Authors (first_name, last_name, biography) VALUES ('George', 'Orwell', 'Author of 1984 and Animal Farm');
INSERT INTO Authors (first_name, last_name, biography) VALUES ('Jane', 'Austen', 'Author of Pride and Prejudice');

-- Books
INSERT INTO Books (title, isbn, publisher_id, book_language_id, price, stock, publication_year)
VALUES ('1984', '9780451524935', 1, 1, 15.99, 50, 1949);
INSERT INTO Books (title, isbn, publisher_id, book_language_id, price, stock, publication_year)
VALUES ('Pride and Prejudice', '9780141439518', 2, 1, 12.99, 30, 1813);

-- Book Authors
INSERT INTO Book_Author (book_id, author_id) VALUES (1, 1);
INSERT INTO Book_Author (book_id, author_id) VALUES (2, 2);

-- Countries
INSERT INTO Country (coountry_name) VALUES ('USA');
INSERT INTO Country (coountry_name) VALUES ('UK');

-- Addresses
INSERT INTO Address (street, city, state, zipcode, country_id) VALUES ('123 Main St', 'New York', 'NY', '10001', 1);
INSERT INTO Address (street, city, state, zipcode, country_id) VALUES ('221B Baker St', 'London', 'England', 'NW1 6XE', 2);

-- Customers
INSERT INTO Customer (first_name, last_name, email, phone)
VALUES ('Alice', 'Johnson', 'alice@example.com', '555-1234');
INSERT INTO Customer (first_name, last_name, email, phone)
VALUES ('Bob', 'Smith', 'bob@example.com', '555-5678');

-- Address Status
INSERT INTO Address_Status (status) VALUES ('Current');
INSERT INTO Address_Status (status) VALUES ('Old');

-- Customer Addresses
INSERT INTO Customer_Address (customer_id, address_id, address_status_id) VALUES (1, 1, 1);
INSERT INTO Customer_Address (customer_id, address_id, address_status_id) VALUES (2, 2, 1);

-- Order Status
INSERT INTO Order_Status (status) VALUES ('Pending');
INSERT INTO Order_Status (status) VALUES ('Shipped');

-- Shipping Methods
INSERT INTO Shipping_Method (method_name, description) VALUES ('Standard', '3-5 business days');
INSERT INTO Shipping_Method (method_name, description) VALUES ('Express', '1-2 business days');

-- Orders
INSERT INTO Cust_Order (customer_id, order_date, shipping_method_id, order_status_id, total_amount)
VALUES (1, '2024-04-10', 1, 1, 15.99);
INSERT INTO Cust_Order (customer_id, order_date, shipping_method_id, order_status_id, total_amount)
VALUES (2, '2024-04-11', 2, 2, 28.98);

-- Order Lines
INSERT INTO Order_Line (cust_order_id, book_id, quantity, unit_price) VALUES (1, 1, 1, 15.99);
INSERT INTO Order_Line (cust_order_id, book_id, quantity, unit_price) VALUES (2, 1, 1, 15.99);
INSERT INTO Order_Line (cust_order_id, book_id, quantity, unit_price) VALUES (2, 2, 1, 12.99);

-- Order History
INSERT INTO Order_History (cust_order_id, order_status_id, status_changed_date)
VALUES (1, 1, '2024-04-10');
INSERT INTO Order_History (cust_order_id, order_status_id, status_changed_date)
VALUES (2, 1, '2024-04-11');
INSERT INTO Order_History (cust_order_id, order_status_id, status_changed_date)
VALUES (2, 2, '2024-04-12');
