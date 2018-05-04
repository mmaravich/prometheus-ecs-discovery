FROM golang:1.9-alpine as builder
RUN apk add --update git

RUN go get -u github.com/teralytics/prometheus-ecs-discovery

FROM alpine:3.6
RUN apk add --no-cache ca-certificates

WORKDIR /app/
COPY --from=builder /go/bin/prometheus-ecs-discovery .

RUN mkdir /config
RUN mkdir /output
ENTRYPOINT ["./prometheus-ecs-discovery", "-config.write-to=/output/ecs_file_sd.yml"]
