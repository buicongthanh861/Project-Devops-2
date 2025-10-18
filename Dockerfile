FROM openjdk:8
COPY target/demo-workshop-2.1.2.jar ttrend.jar
ENTRYPOINT ["java","-jar","ttrend.jar"]