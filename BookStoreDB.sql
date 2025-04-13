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
    cost DECIMAL(10,2) NOT NULL
);

-- order_status table
 CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
