FROM tomcat:10-jdk8

EXPOSE 8080

COPY ./WebContent/WEB-INF/lib/sqljdbc4.jar /usr/local/tomcat/lib/sqljdbc4.jar
COPY ./WebContent/WEB-INF/lib/mysql-connector-java-5.1.26-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.26-bin.jar

CMD ["catalina.sh", "run"]
