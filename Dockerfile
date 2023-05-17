FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD
COPY ./ ./
RUN mvn clean package -DskipTests=true

FROM adoptopenjdk:11-jre-hotspot as builder
COPY --from=MAVEN_BUILD /target/*.jar /application.jar

RUN java -Djarmode=layertools -jar application.jar extract

FROM adoptopenjdk:11-jre-hotspot
COPY --from=builder dependencies/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]

LABEL org.opencontainers.image.ref.name="ubuntu"
LABEL org.opencontainers.image.title="httpcustom"
LABEL org.opencontainers.image.version="0.0.1"
LABEL org.springframework.boot.version="2.6.6"
LABEL org.springframework.boot.spring-configuration-metadata.json=""
LABEL org.springframework.cloud.dataflow.spring-configuration-metadata.json=""