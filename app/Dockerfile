# builder image
FROM golang:1.17.2 as builder
RUN mkdir /build
ADD src/* /build/
ADD .env /build/
WORKDIR /build
RUN go mod download && \
    CGO_ENABLED=0 go build -o weather-app .


# generate clean, final image for end users
FROM alpine
COPY --from=builder /build/weather-app .
COPY --from=builder /build/.env .

# executable
ENTRYPOINT [ "./weather-app" ]