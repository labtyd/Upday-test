FROM jetty

COPY helloworld.jar /var/lib/jetty/webapps/

RUN java -jar "$JETTY_HOME/start.jar" --create-startd --add-to-start=jmx,stats

WORKDIR /var/lib/jetty/webapps/

USER jetty

CMD [ "java", "-XX:+UseContainerSupport", "-jar" , "/var/lib/jetty/webapps/helloworld.jar"]