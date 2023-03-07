# syntax=docker/dockerfile:1

## Build
FROM golang:1.20-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /feedgerald

## Deploy
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /feedgerald /feedgerald

EXPOSE 3000

USER nonroot:nonroot

ENTRYPOINT ["/feedgerald"]
