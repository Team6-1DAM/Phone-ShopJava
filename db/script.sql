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





INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Alvaro','alvaro@alvaro.es',976587893,'Zaragoza','2000-10-05','admin','Alvaro','a');

INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Alessia','alessia@alessia.es',976587843,'Lanzarote','1995-10-05','admin','Alessia','a');

INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Miguel','miguel@miguel.es',976587893,'Zaragoza','1981-10-05','admin','Miguel','m');

INSERT INTO user(name,email,phone,city,birth_date,role,username,password)
VALUES('Roberto','roberto@roberto.es',976587893,'Zaragoza','1981-10-05','user','Roberto','r');


INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('RetroPC','+34607658712','Calle Tar,4','50500','Tarazona','España','retropc.es','retropc@gmail.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('Manuel Hidalgo Saavedra','+34605787214','Calle Sev,5','41012','Sevilla','España','segundavidaPc.es','mhidalgo@gmail.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('CentroMail calle Cadiz','+34976521697','Calle Cadiz,12','50004','Zaragoza','España','game.es','gameZcadiz@game.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('Star Games','+34978881697','Centro Independencia,21','50004','Zaragoza','España','stargames.es','stargames@star.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('Retro Games','+34976882296','poligono Centrovia,21','50250','La Muela','España','retrogames.es','retrogames@games.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('CEX','+34976111699','Calle Dr Val-Carreres,1','50004','Zaragoza','España','cex.com','cexzar@cex.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('Old School','+34979221688','Calle Bilbao,9','50004','Zaragoza','España','oldschool.com','oldschoolzgz@retropc.com');

INSERT INTO supplier(name,tel,address,zip_code,city,country,website,email)
VALUES('RetroMaC','+3497674767','Calle San Juan Bosco,8','50010','Zaragoza','España','retromac.com','retromaczgz@retromac.com');
--
--
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(1,'Commodore 64','Micrordenador de 8 bits de los 80, el micrordenado mas vendido en el mundo',180.50,1,'no_image.jpg',
   '1982-01-02','Bueno con roces en la entrada de cartuchos');

INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(1,'Spectrum','Micrordenador de 8 bits de los 80, con mucho exito en Europa, Britanico',120.80,1,'no_image.jpg',
       '1982-01-03','Decente, las letras de las teclas no se ven bien');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(1,'Amstrad CPC464','Micrordenador de 8 bits de los 80, con mucho exito en España, muy buen Basic',150,1,'no_image.jpg',
       '1985-01-05','Buena, El cassete integrado falla a veces al leer');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(2,'Sony MSX','Micrordenador de 8 bits de los 80, con mucho exito en Japon',198.80,1,'no_image.jpg',
       '1984-01-04','Bueno, no se aprecian defectos');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(2,'Commodore Amiga 500','Micrordenador de 16 bits de los 80, ordenador con sistema de ventanas',201,1,'no_image.jpg',
       '1985-06-01','Buena, la disquetera muestra algun error de lectura');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'PC 286 sin coprocesador matemático','Pc de 16 bits de finales de los 80, con 20MB de disco duro',129.99,1,'no_image.jpg',
       '1988-05-15','Decente, el monitor de fosforo verde tarda encender');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'PC 486 DX50','PC de principios de los 90,lleva coprocesador integrado 40MB de disco duro',139.99,1,'no_image.jpg',
       '1993-01-01','Bueno, la carcasa esta un poco amarillenta');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(3,'PC Pemtium I 133Mhz','Ordenador preparado para Windows 95',149.99,1,'no_image.jpg',
       '1995-11-11','Bueno, no se aprecian defectos');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(4,'PC Pemtium III','Ordenador preparado para Windows XP',159.99,1,'no_image.jpg',
       '2001-12-03','Bueno, el lector CD-ROM da fallos de lectura');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(5,'Portatil ASUS Multimedia','Ordenador portatil para Windows 7, con un i7 de primera generacion',169.99,1,'no_image.jpg',
       '2010-12-03','Bueno, la fuente de alimentacion externa recien cambiada');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(7,'PC torre Gaming personalizada','Ordenador gaming para Windows 10, con un i5 de octava generacion',269.99,1,'no_image.jpg',
       '2017-11-05','Bueno, tiene 8GB de RAM y una GTX1060 de 6GB ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(7,'Portatil Gaming 2018','Ordenador portatil gaming para Windows 10, con un i7 de octava generacion',299.99,1,'no_image.jpg',
       '2018-06-02','Bueno, tiene 12GB de RAM y una GTX1050 de 4GB ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'Apple I','Primer ordenador de apple',667.00,1,'no_image.jpg',
       '1976-01-02','Muy Bueno, intacto ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'Apple II','Primer ordenador con exito comercial de apple',1298.00,1,'no_image.jpg',
       '1977-06-01','Muy Buen estado de conservación ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'Apple III','Primer ordenador de los 80 de apple',1800.00,1,'no_image.jpg',
       '1980-01-02','Bueno ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'Apple Lisa','Pototipo de apple de sistema de ventanas',1999.99,1,'no_image.jpg',
       '1983-05-03','Muy Bueno ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'Apple Macintosh','Viene de un grupo de Ordenadores que provienen de la universidad de Zaragoza',599.99,1,'no_image.jpg',
       '1984-07-01','Muy Usado, con muchos roces todas las unidades');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'PowerMac 5200','Orenador de apple muy usado en edicion en los 90',799.99,1,'no_image.jpg',
       '1995-10-05','Muy Bueno ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'IMac G3','Ordenador con momitor integrado de finales de los 90',999.99,1,'no_image.jpg',
       '1998-12-01','Muy Bueno ');
INSERT INTO products(id_supplier,product_name,description,sale_price,stocks_units,image,release_date,product_status)
VALUES(8,'iMac G4','Potente edicion y buen diseño de principios de los 2000',799.99,1,'no_image.jpg',
       '2002-04-01','Muy Bueno ');