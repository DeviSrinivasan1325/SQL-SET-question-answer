CREATE DATABASE Set3debugg;
USE Set3debugg;

CREATE TABLE employees ( employee_id INT PRIMARY KEY, 
						name VARCHAR(50), age INT, 
                        salary INT, department_id INT );
INSERT INTO employees (employee_id, name, age, salary, department_id) 
VALUES (1, 'John', 30, 60000, 101), 
		(2, 'Emily', 25, 48000, 102), 
        (3, 'Michael', 40, 75000, 103), 
        (4, 'Sara', 35, 56000, 101), 
        (5, 'David', 28, 49000, 102);
CREATE TABLE departments ( department_id INT PRIMARY KEY, department_name VARCHAR(50) );
INSERT INTO departments (department_id, department_name) VALUES (101, 'HR'), (102, 'Finance'), (103, 'IT'), (104, 'Marketing');

CREATE TABLE sales ( sale_id INT PRIMARY KEY, customer_id INT, amount DECIMAL(10,2), sale_date DATE );
INSERT INTO sales (sale_id, customer_id, amount, sale_date) 
VALUES (1, 101, 4500.00, '2023-03-15'), 
	(2, 102, 5500.00, '2023-03-16'), 
    (3, 103, 7000.00, '2023-03-17'), 
    (4, 104, 3000.00, '2023-03-18'), 
    (5, 105, 6000.00, '2023-03-19');

CREATE TABLE customers ( customer_id INT PRIMARY KEY, customer_name VARCHAR(50) );
INSERT INTO customers (customer_id, customer_name) 
VALUES (101, 'John Doe'), (102, 'Jane Smith'), (103, 'Alice Johnson'), (104, NULL), (105, 'Robert Brown');

-- Creating orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    order_amount INT
);
INSERT INTO orders (order_id, customer_name, order_date, order_amount) VALUES
(1, 'John', '2023-05-01', 500),
(2, 'Emily', '2023-05-02', 700),
(3, 'Michael', '2023-05-03', 1200),
(4, 'Sara', '2023-05-04', 450),
(5, 'David', '2023-05-05', 900);

-- Question 1: Get names and salaries of employees in the Finance department. 
-- Incorrect Code: 
SELECT name, salary FROM employees WHERE department_id = 'Finance';
-- Correct Code:
SELECT e.name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- Question 2: Calculate total sales for each customer. 
-- Incorrect Code: 
SELECT customer_name, SUM(amount) AS total_sales FROM sales GROUP BY customer_name;
-- Correct Code:
SELECT c.customer_name, SUM(s.amount) AS total_sales 
FROM sales s 
JOIN customers c ON c.customer_id = s.customer_id GROUP BY customer_name;

-- Question 3: Find customers with an order amount of 1000. 
-- Incorrect Code: 
SELECT DISTINCT customer_name FROM orders WHERE order_amount = 1000;
-- Correct Code:
SELECT DISTINCT customer_name
FROM orders
WHERE order_amount <= 1000;

-- Question 4: Find employees with a salary greater than 50000. 
-- Incorrect Code: 
SELECT name, salary FROM employees WHERE salary => 50000;
-- Correct Code:
SELECT name, salary 
FROM employees 
WHERE salary <= 50000;

-- Question 5: Find customers whose name starts with 'J'. 
-- Incorrect Code: 
SELECT customer_name FROM customers WHERE customer_name = 'J%';
-- Correct Code:
SELECT customer_name 
FROM customers 
WHERE customer_name LIKE 'J%';