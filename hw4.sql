-- STEP 1
DROP DATABASE IF EXISTS LibraryManagement;
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- STEP 2
USE LibraryManagement;

INSERT INTO authors (author_name)
VALUES
    ('George Orwell'),
    ('J.K. Rowling');

INSERT INTO genres (genre_name)
VALUES
    ('Dystopian'),
    ('Fantasy');

INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES
    ('1984', 1949, 1, 1),
    ('Harry Potter and the Philosopher''s Stone', 1997, 2, 2);

INSERT INTO users (username, email)
VALUES
    ('oleg_user', 'oleg@example.com'),
    ('anna_reader', 'anna@example.com');

INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES
    (1, 1, '2026-03-01', '2026-03-10'),
    (2, 2, '2026-03-05', '2026-03-15');
	
-- STEP 3
USE hw3_db;

SELECT
    od.id AS order_detail_id,
    od.order_id,
    od.product_id,
    od.quantity,
    o.id AS order_id_from_orders,
    o.date,
    o.customer_id,
    o.employee_id,
    o.shipper_id,
    c.name AS customer_name,
    p.name AS product_name,
    cat.name AS category_name,
    s.name AS supplier_name,
    sh.name AS shipper_name,
    e.first_name,
    e.last_name
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id;
	
-- STEP 4.1
SELECT COUNT(*) AS total_rows
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id;
	
-- STEP 4.2
SELECT COUNT(*) AS total_rows_left_join
FROM order_details AS od
LEFT JOIN orders AS o
    ON od.order_id = o.id
LEFT JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
LEFT JOIN employees AS e
    ON o.employee_id = e.employee_id
LEFT JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id;
	
-- STEP 4.3
SELECT
    od.id AS order_detail_id,
    od.order_id,
    od.product_id,
    od.quantity,
    o.employee_id,
    cat.name AS category_name
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10;
  
-- STEP 4.4 4.5
SELECT
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

-- STEP 4.6 4.7
SELECT
    cat.name AS category_name,
    COUNT(*) AS row_count,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o
    ON od.order_id = o.id
INNER JOIN customers AS c
    ON o.customer_id = c.id
INNER JOIN products AS p
    ON od.product_id = p.id
INNER JOIN categories AS cat
    ON p.category_id = cat.id
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id
INNER JOIN shippers AS sh
    ON o.shipper_id = sh.id
INNER JOIN suppliers AS s
    ON p.supplier_id = s.id
WHERE o.employee_id > 3
  AND o.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY row_count DESC
LIMIT 4 OFFSET 1;