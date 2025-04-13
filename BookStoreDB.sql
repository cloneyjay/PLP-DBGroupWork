create database if not exists BookStoreDB;


use BookStoreDB;
CREATE TABLE customer_address (
    customer_id INT PRIMARY KEY,
    address_id INT,
    address_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(address_status_id)
);


INSERT INTO customer_address (customer_id, address_id, address_status_id) VALUES 
(),
(),
();



CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(100),
    zipcode VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);


INSERT INTO address (street, city, state, zipcode, country_id) VALUES 
('', '', '', '', ),
('', '', '', '', ),
('', '', '', '', );


CREATE TABLE address_status (
    address_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL
);

INSERT INTO address_status (status) VALUES 
("Current"),
("Old");


CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

INSERT INTO country (country_name) VALUES 
(),
(),
(),
();


CREATE TABLE cust_order (
    cust_order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    order_status_id INT,
    total_amount DECIMAL (10,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

INSERT INTO cust_order (customer_id, shipping_method_id, order_status_id, total_amount) 
VALUES 
(),
(); 


CREATE TABLE order_line (
    orderline_id INT PRIMARY KEY,
    cust_order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cust_order_id) REFERENCES cust_order(cust_order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_line_id, cust_order_id, book_id, quantity, unit_price) 
VALUES 
(),  
(),  
(); 





