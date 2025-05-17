FROM tomcat:9.0.104-jdk21-temurin-jammy
# Copia el archivo WAR generado por Maven al directorio webapps de Tomcat
COPY target/PhoneShop /usr/local/tomcat/webapps/phoneshop

# Comando para ejecutar Tomcat
RUN mkdir -p /opt/phoneshop/pictures
CMD ["catalina.sh", "run"]