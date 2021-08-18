FROM golang:1.16-alpine as app-builder

WORKDIR /api
COPY . .
RUN go mod download
RUN go build -o ./app main.go

FROM alpine:3.14

RUN apk --no-cache add ca-certificates

RUN mkdir -p /api
WORKDIR /api

COPY --from=app-builder /api/app .

ENV GIN_MODE=release
EXPOSE 8080

ENTRYPOINT ["./app", "run"]