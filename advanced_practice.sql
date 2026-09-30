USE online_store;
CREATE TABLE customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(45),
    last_name VARCHAR(45)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT NULL,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

SELECT * FROM customers;
SELECT * FROM orders;

-- Task 1: INNER JOIN

SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders INNER JOIN customers ON orders.id = orders.customer_id;

-- Task 2: LEFT JOIN
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders LEFT JOIN customers ON orders.id = orders.customer_id;

-- Task 3: GROUP BY with SUM
SELECT customer_id, SUM(total_amount) AS total_spent FROM orders GROUP BY customer_id;
SELECT 
	customer_id, 
    customers.first_name, 
    customers.last_name,
	SUM(total_amount) AS total_spent
FROM orders 
INNER JOIN customers ON orders.customer_id = customers.id
GROUP BY customer_id, customers.first_name, customers.last_name;

-- Task 4: GROUP BY with COUNT
SELECT customer_id,
       COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;

-- Task: WHERE and HAVING

SELECT 
	customer_id,
    customers.first_name,
    customers.last_name,
    SUM(total_amount) AS total_spent
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
WHERE total_amount > 100
GROUP BY customer_id, customers.first_name, customers.last_name
HAVING total_spent > 150;

-- Task: SubQuery
SELECT id, customer_id, total_amount
FROM orders
WHERE total_amount >= (
    SELECT AVG(total_amount)
    FROM orders
);


