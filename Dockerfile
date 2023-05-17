FROM golang:1.20.4-alpine3.18 AS builder
RUN apk add --no-cache --update git

WORKDIR /var/www
COPY . .
RUN go get -d -v \
  && go install -v \
  && go build -ldflags '-w -s' -a -installsuffix cgo -o main .

FROM scratch
COPY --from=builder /var/www/main .
EXPOSE 3000
CMD [ "./main" ]