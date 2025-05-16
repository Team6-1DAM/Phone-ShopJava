

-- Creamos la tabla user
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone BIGINT,
    city VARCHAR(100),
    birth_date DATE,
    role VARCHAR(100),
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(200)
);

-- Creamos la tabla supplier
CREATE TABLE supplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    tel VARCHAR(18),
    address VARCHAR(50),
    zip_code VARCHAR(5),
    city VARCHAR(50),
    country VARCHAR(50),
    website VARCHAR(50),
    email VARCHAR(50)
);

-- Creamos la tabla products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_supplier INT,
    product_name VARCHAR(50),
    description VARCHAR(150),
    sale_price DECIMAL(9,2),
    stocks_units BOOLEAN,
    image VARCHAR(100),
	release_date DATE,
	product_status VARCHAR(100),
    FOREIGN KEY (id_supplier) REFERENCES supplier(id) ON DELETE CASCADE
);


-- Creamos la tabla orders
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    id_product INT,
    order_date DATE,
    total_price DECIMAL(9,2),
    username VARCHAR(100),
    notes VARCHAR(400),
    FOREIGN KEY (id_product) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (id_user) REFERENCES user(id) ON DELETE CASCADE
);
