FROM tomcat:10.1.18

ADD target/Syndic.war /usr/local/tomcat/webapps/


EXPOSE 80

CMD ["catalina.sh", "run"]