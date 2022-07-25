FROM gradle:7-jdk11-alpine AS build

WORKDIR /usr/src/twitter-feur-bot

COPY --chown=gradle:gradle . .

RUN gradle build --no-daemon

FROM openjdk:16-alpine

WORKDIR /usr/src/twitter-feur-bot

COPY --from=build /usr/src/twitter-feur-bot/build/libs/*.jar ./app/twitter-feur-bot.jar

EXPOSE 8000

ENTRYPOINT ["java", "-Xmx4G", "-jar", "/app/twitter-feur-bot.jar"]
