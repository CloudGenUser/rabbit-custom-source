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
LABEL org.opencontainers.image.title="rabbitcustom"
LABEL org.opencontainers.image.version="0.0.2"
LABEL org.springframework.boot.version="2.6.6"
LABEL org.springframework.boot.spring-configuration-metadata.json="{\"groups\": [{\"name\": \"rabbit.supplier\",\"type\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\"},{\"name\": \"spring.rabbitmq\",\"type\": \"org.springframework.boot.autoconfigure.amqp.RabbitProperties\",\"sourceType\": \"org.springframework.boot.autoconfigure.amqp.RabbitProperties\"}],\"properties\": [{\"name\": \"rabbit.supplier.requeue\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"true\"},{\"name\": \"rabbit.supplier.transacted\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"false\"},{\"name\": \"rabbit.supplier.queues\",\"type\": \"java.lang.String[]\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.supplier.mappedRequestHeaders\",\"type\": \"java.lang.String[]\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"{'STANDARD_REQUEST_HEADERS'}\"},{\"name\": \"rabbit.supplier.initialRetryInterval\",\"type\": \"java.lang.Integer\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"1000\"},{\"name\": \"spring.rabbitmq.addresses\",\"type\": \"java.lang.String\",\"sourceType\": \"org.springframework.boot.autoconfigure.amqp.RabbitProperties\",\"defaultValue\": \"\"}]}"
LABEL org.springframework.cloud.dataflow.spring-configuration-metadata.json="{\"groups\": [{\"name\": \"rabbit.supplier\",\"type\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\"},{\"name\": \"spring.rabbitmq\",\"type\": \"org.springframework.boot.autoconfigure.amqp.RabbitProperties\",\"sourceType\": \"org.springframework.boot.autoconfigure.amqp.RabbitProperties\"}],\"properties\": [{\"name\": \"rabbit.supplier.requeue\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"true\"},{\"name\": \"rabbit.supplier.transacted\",\"type\": \"java.lang.Boolean\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"false\"},{\"name\": \"rabbit.supplier.queues\",\"type\": \"java.lang.String[]\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"\"},{\"name\": \"rabbit.supplier.mappedRequestHeaders\",\"type\": \"java.lang.String[]\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"{'STANDARD_REQUEST_HEADERS'}\"},{\"name\": \"rabbit.supplier.initialRetryInterval\",\"type\": \"java.lang.Integer\",\"sourceType\": \"com.cloudgen.n3xgen.rabbitCustom.bean.RabbitSupplierProperties\",\"defaultValue\": \"1000\"},{\"name\": \"spring.rabbitmq.addresses\",\"type\": \"java.lang.String\",\"sourceType\": \"org.springframework.boot.autoconfigure.amqp.RabbitProperties\",\"defaultValue\": \"\"}]}"