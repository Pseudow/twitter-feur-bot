FROM gradle:7-jdk11-alpine

WORKDIR /usr/src/twitter-feur-bot

COPY --chown=gradle:gradle . .

RUN gradle build --no-daemon

EXPOSE 8000

FROM openjdk:16-alpine

WORKDIR /usr/src/twitter-feur-bot

COPY --from=build /usr/src/twitter-feur-bot/build/libs/*.jar ./app/twitter-feur-bot.jar

ENTRYPOINT ["java", "-Xmx4G", "-jar", "/app/twitter-feur-bot.jar"]
