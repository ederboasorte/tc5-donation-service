# syntax=docker/dockerfile:1

FROM golang:1.21-alpine AS builder
WORKDIR /src

COPY go.mod go.sum ./
RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct && go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags='-s -w' -o /usr/local/bin/donation-service .

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /usr/local/bin/donation-service /usr/local/bin/donation-service
USER nonroot:nonroot

EXPOSE 8082
ENTRYPOINT ["/usr/local/bin/donation-service"]
