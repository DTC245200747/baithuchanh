-- FlashMart: truy van bao cao Marketing va Kho van (MySQL 8+)
-- Chi chay tren CSDL bai tap: khoi tao lai 3 bang de co ket qua mau on dinh.
CREATE DATABASE IF NOT EXISTS flashmart_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE flashmart_db;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_id, name) VALUES
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Products (product_id, product_name) VALUES
(101, 'Laptop'), (102, 'Mouse'), (103, 'Keyboard');

INSERT INTO Orders (order_id, customer_id, product_id) VALUES
(1001, 1, 101), (1002, 1, 102), (1003, 2, 101);

-- Bao cao 1: Giu tat ca khach hang, ke ca khach chua mua.
-- COUNT(o.order_id) bo qua NULL nen Charlie co 0 don.
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM Customers AS c
LEFT JOIN Orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

-- Bao cao 2: San pham chua tung xuat hien trong don hang (anti-join).
SELECT p.product_id, p.product_name
FROM Products AS p
LEFT JOIN Orders AS o ON p.product_id = o.product_id
WHERE o.order_id IS NULL
ORDER BY p.product_id;

-- Kiem tra so luong dong bao cao: mong doi 3 khach hang va 1 san pham chua ban.
SELECT COUNT(*) AS total_customers FROM Customers;
SELECT COUNT(*) AS unsold_products
FROM Products AS p
LEFT JOIN Orders AS o ON p.product_id = o.product_id
WHERE o.order_id IS NULL;
