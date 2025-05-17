# Phone-ShopJava
Tienda de Telefonos de segunda mano hecha en Java/Tomcat/mariaDB
Phone-Shop - Aplicacion Web -

Phone-Shop es la primera version de una pagina funcional de compra - venta de telefonos moviles, aceptando articulos de todas las epocas. En la version 1.0 está implementado el control de usuarios, la lista de productos a la venta,proveedores de los productos y realizacion de pedidos. La aplicacion cambia de aspecto segun el tipo de usuario.El administrador de la página puede tener acceso al CRUD completo de tres tablas implementadas ( USERS, SUPPLIERS, PRODUCTS), de la tabla Orders no se ha habilitado nada mas que la generacion de registros. El administrador tiene una vista ampliada de los datos de un producto conociendo sus unidades disponibles. Un usuario anonimo solo puede ver los productos, un usuario registrado podra comprar el producto y modificar sus datos de usuario. 

Para ello se ha cosnstruido la base de datos con MariaDB. Se ha dockerizado el uso de la BD para una mayor flexibilidad a la hora de realizar pruebas.

IMPORTANTE: las imagenes se suben a la carpeta /webapps/phoneshop_images en el directorio local donde este instalado tomcat, hay que crearla inicialmente y poner la imagen no_image.jpg para que se puedan visualizar directamente los registros iniciales. Dicha imagen esta en el directorio docs del repositorio. En dicho repositorio tambien hay documentacion de la estructura de la Base de datos y su esquema relacional y los scripst iniciales de creacion y registros iniciales de la base de dato. Dichos Scripts tambien se encuentran como parte del código en la carpeta db del proyecto. Dicho script lo utiliza el para generar la base de datos cada vez que se realiza ejecutando la docker compose -f docker-compose.dev.yaml up -d , levantando asi un contenedor de pruebas.

Nos hemos vasado en el servidor de aplicacionse APACHE TOMCAT v9.0.x, así como en la version Temurin 21.0.7 del jdk de JAVA. Tambien sugerimos la instalacion de APACHE MAVEN 3.9.6 o superior. 
Para iniciar la aplicacion, una vez creada la BD con el contenedor y su script inicial suministrado, basta con realizar un despliege habitual. Para iniciar la aplicacion ejecutamos en consola la siguiente instruccion mvn clean tomcat7:deploy . 


Nos vamos a un navegador y ponemos la direccion.. http://localhost:8080/phone_shop/

Es aqui donde se visualiza nuestro aplicativo en el frontend, y donde ya podemos empezar a operar en la aplicacion. Lo primero que hay que realizar es registrarse como un usuario. Si queremos ver la s funcionalidades del administrador tenemos tres usuarios ya creados para ello:
  username: alvaro , password: a
  username: alessia, password: a
  username: miguel, password: m
Desde estos ussuarios se puede realizar toda la operativa de la aplicacion web.

Tambien se ha dockerizado por completo el proyecto, realizando un docker-comopose en el que hay una imagen de la BD y de la aplicación, corriendo en el equipo sin necesidad de tener maven, tomcat y mariadb instalado, simplemente hay que ejecutar el docker-compose.



  
