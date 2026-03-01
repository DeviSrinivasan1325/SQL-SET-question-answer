Create Database Set3Coding;
Use Set3Coding;
-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary INT,
    department_id INT
);

-- Insert Employee Data
INSERT INTO employees (employee_id, name, age, salary, department_id) VALUES
(1, 'John', 30, 60000, 101),
(2, 'Emily', 25, 48000, 102),
(3, 'Michael', 40, 75000, 103),
(4, 'Sara', 35, 56000, 101),
(5, 'David', 28, 49000, 102),
(6, 'Robert', 45, 90000, 103),
(7, 'Sophia', 29, 51000, 102);

-- Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert Department Data
INSERT INTO departments (department_id, department_name) VALUES
(101, 'HR'),
(102, 'Finance'),
(103, 'IT');

-- Create Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    sale_date DATE
);

-- Insert Sales Data
INSERT INTO sales (sale_id, customer_id, amount, sale_date) VALUES
(1, 101, 4500.00, '2023-03-15'),
(2, 102, 5500.00, '2023-03-16'),
(3, 103, 7000.00, '2023-03-17'),
(4, 104, 3000.00, '2023-03-18'),
(5, 105, 6000.00, '2023-03-19');

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

-- Insert Product Data
INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Laptop', 1000),
(2, 'Mobile', 500),
(3, 'Tablet', 300),
(4, 'Headphones', 100),
(5, 'Smartwatch', 200);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    order_amount INT
);

-- Insert Order Data
INSERT INTO orders (order_id, customer_name, order_date, order_amount) VALUES
(1, 'John', '2023-05-01', 500),
(2, 'Emily', '2023-05-02', 700),
(3, 'Michael', '2023-05-03', 1200),
(4, 'Sara', '2023-05-04', 450),
(5, 'David', '2023-05-05', 900),
(6, 'John', '2023-05-06', 600),
(7, 'Emily', '2023-05-07', 750);

-- Questions:

-- 1. Identify Customers with No Orders in the Last 30 Days.
-- Find customers who have not placed any orders in the last 30 days.
SELECT customer_name
FROM orders
GROUP BY customer_name
HAVING MAX(order_date) < '2023-05-10' - INTERVAL 30 DAY;

-- 2. Find Employees Who Earn Above Department Average.
-- Retrieve employee names and their salaries who earn more than the average salary of their respective department.
SELECT name, salary,department_id
FROM employees 
 WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE department_id = department_id);

-- 3. Identify Products with a Price Above Average.
-- Find products whose price is above the average price of all products.
SELECT product_name, price
FROM products 
WHERE price >(
	SELECT AVG(price)
    FROM products);

-- 4. Find Customers Who Placed Multiple Orders.
-- Identify customers who have placed more than one order.
SELECT customer_name, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_name
HAVING COUNT(*)>1;

-- 5. Detect Employees with the Same Salary.
-- Find employees who have the same salary as someone else.
SELECT name,salary
FROM employees
WHERE salary IN (
	SELECT salary
	FROM employees
	GROUP BY salary
	HAVING COUNT(*) > 1);