FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/todo-service .
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/todo-service .
EXPOSE 8080
CMD ["./todo-service"]