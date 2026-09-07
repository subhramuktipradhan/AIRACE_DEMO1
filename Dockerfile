FROM gradle:latest AS build

WORKDIR /app

COPY . .

RUN gradle clean installDist --no-daemon

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/app/build/install/app .

CMD ["./bin/app"]