create database if not exists BookStoreDB;
use BookStoreDB;

-- order_history table
 CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    changed_at DATETIME NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

 --  shipping_method table
 CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2) NOT NULL
);

-- order_status table
 CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
