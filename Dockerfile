FROM docker.io/library/maven:3.8-jdk-11 as builder
RUN mkdir /build
ADD spring /build/spring
ADD quarkus /build/quarkus
WORKDIR /build
RUN mvn -B clean verify -DskipTests -f spring/pom.xml
RUN mvn -B clean verify -DskipTests -f quarkus/pom.xml

FROM docker.io/library/maven:3.8-jdk-11
RUN mkdir -p /opt/target/spring; mkdir -p /opt/target/quarkus
COPY --from=builder /build/spring/target/* /opt/target/spring/
COPY --from=builder /build/quarkus/target/* /opt/target/quarkus