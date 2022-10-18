FROM cgr.dev/chainguard/jdk:sha256:d8f435ffab139985ab2d505031c8507fc25eedbae0f91bc71edc1914029263da AS build
COPY ./* ./
RUN mvn clean install

FROM cgr.dev/chainguard/jdk:sha256:d8f435ffab139985ab2d505031c8507fc25eedbae0f91bc71edc1914029263da
COPY --from=build target/text4shell-1.0.0-SNAPSHOT.jar text4shell-1.0.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","text4shell-1.0.0-SNAPSHOT.jar"]