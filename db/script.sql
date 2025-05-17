CREATE DATABASE phone_shop;
GRANT ALL PRIVILEGES ON phone_shop.* TO alvaro;
USE phone_shop;

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


CREATE TABLE supplier (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          supplier_name VARCHAR(50),
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





INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Alvaro','alvaro@alvaro.es',976587893,'Zaragoza','2000-10-05','admin','Alvaro','a');

INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Alessia','alessia@alessia.es',976587843,'Lanzarote','1995-10-05','admin','Alessia','a');

INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Miguel','miguel@miguel.es',976587893,'Zaragoza','1981-10-05','admin','Miguel','m');

INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Roberto','roberto@roberto.es',976587893,'Zaragoza','1981-10-05','user','Roberto','r');


INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('RetroPC','+34607658712','Calle Tar,4','50500','Tarazona','España','retropc.es','retropc@gmail.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('Manuel Hidalgo Saavedra','+34605787214','Calle Sev,5','41012','Sevilla','España','segundavidaPc.es','mhidalgo@gmail.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('CentroMail calle Cadiz','+34976521697','Calle Cadiz,12','50004','Zaragoza','España','game.es','gameZcadiz@game.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('Star Games','+34978881697','Centro Independencia,21','50004','Zaragoza','España','stargames.es','stargames@star.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('Retro Games','+34976882296','poligono Centrovia,21','50250','La Muela','España','retrogames.es','retrogames@games.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('CEX','+34976111699','Calle Dr Val-Carreres,1','50004','Zaragoza','España','cex.com','cexzar@cex.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('Old School','+34979221688','Calle Bilbao,9','50004','Zaragoza','España','oldschool.com','oldschoolzgz@retropc.com');

INSERT INTO supplier(supplier_name,tel,address,zip_code,city,country,website,email)
VALUES('RetroMaC','+3497674767','Calle San Juan Bosco,8','50010','Zaragoza','España','retromac.com','retromaczgz@retromac.com');
--
--
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(1,'Nokia 3310','Strong Design',180.50,1,'nokia.jpg',
   '2000-01-02','Brand New');

INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'Motorola RAZR V3',' Thin and Elegant',120.80,1,'motorola.jpg',
       '2004-01-03','Upper part has got some scratches');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(1,'Blackberry 7290','Querty Keyboard',150,1,'blackberry.jpg',
       '1985-01-05','Some Keys are not visible');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(2,'Iphone 11','Dual Camara',198.80,1,'iphone.jpg',
       '1984-01-04','The movil camera is a little bit ... ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(2,'Huawei P20','P series with fingerprint ',201,1,'huawey.jpg',
       '1985-06-01','Good conditions');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'LG Chocolate','Slider style phone',129.99,1,'lg.jpg',
       '1988-05-15','Fingerprint sometimes does not work');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'HTC ThunderBolt','4G LTE phone',139.99,1,'htc.jpg',
       '1993-01-01','Hard to slide');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'Samsung S24 Ultra','IA phone',149.99,1,'samsung.jpg',
       '1995-11-11','Screen a little bit scratched');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(4,'Iphone Original 2007','OS touchscreen',159.99,1,'iphonev1.jpg',
       '2001-12-03','Good conditions');
