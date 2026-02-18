CREATE DATABASE Set2Query;
USE Set2Query;

-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary INT,
    department_id INT
);

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

INSERT INTO departments (department_id, department_name) VALUES
(101, 'HR'),
(102, 'Finance'),
(103, 'IT');
select * from sales;
-- Create Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    sale_date DATE,
    product_id INT
);

INSERT INTO sales (sale_id,product_id,customer_id, amount, sale_date) VALUES
(1, 1,101, 4500.00, '2023-03-15'),
(2, 2,102, 5500.00, '2023-03-16'),
(3, 3, 103, 7000.00, '2023-03-17'),
(4, 4,104, 3000.00, '2023-03-18'),
(5, 5,105, 6000.00, '2023-03-19');

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

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
ALTER TABLE orders
MODIFY order_date DATETIME;
select * from orders;
INSERT INTO orders (order_id, customer_name, order_date, order_amount) VALUES
(1, 'John', '2023-05-01 10:15:00', 500),
(2, 'Emily', '2023-05-01 10:45:00', 700),
(3, 'Michael', '2023-05-03 11:00:00', 1200),
(4, 'Sara', '2023-05-04 10:30:00', 450),
(5, 'David', '2023-05-04 10:15:00', 900),
(6, 'John', '2023-05-06 11:00:00', 600),
(7, 'Emily', '2023-05-07 11:00:00', 750);
select *from orders;
-- Question 1: Find Employees with Highest Salary Per Department
-- Retrieve the employee name, department name, and salary for the highest-paid employee in each department.
SELECT e.name,d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary = (SELECT MAX(salary) FROM employees WHERE  department_id = e.department_id);

-- Question 2: Calculate Monthly Sales Growth Percentage
-- Calculate the month-over-month sales growth percentage for each product using the sales table.
WITH monthly_sales AS (
    SELECT
        product_id,
        DATE_FORMAT(sale_date, '%Y-%m') AS month,
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY product_id, DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    m.product_id,
    p.product_name,
    m.month,
    m.total_sales,
    ROUND(
        (m.total_sales - prev_sales) / prev_sales * 100,
        2
    ) AS sales_growth_percentage
FROM (
    SELECT
        *,
        LAG(total_sales) OVER (
            PARTITION BY product_id
            ORDER BY month
        ) AS prev_sales
    FROM monthly_sales
) m
JOIN products p
  ON m.product_id = p.product_id;

-- Question 3: Identify Departments with Average Salary Greater Than Company Average
-- List department names where the average salary is greater than the company's average salary.
SELECT d.department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);

-- Question 4: Find Customers with Consecutive Purchases
-- Identify customers who made purchases on two or more consecutive days.
SELECT DISTINCT o1.customer_name
FROM orders o1
JOIN orders o2 ON o1.customer_name = o2.customer_name 
AND DATEDIFF(o1.order_date, o2.order_date) = 1;

-- Question 5: Detect Overlapping Orders
-- Find orders where two or more customers placed orders within the same hour, based on order_date and time.
SELECT 
    DATE(order_date) AS order_day,
    HOUR(order_date) AS order_hour,
    COUNT(DISTINCT customer_name) AS customer_count
FROM orders
GROUP BY DATE(order_date), HOUR(order_date)
HAVING COUNT(DISTINCT customer_name) >= 2;


