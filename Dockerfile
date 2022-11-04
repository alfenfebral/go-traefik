FROM golang:alpine

ENV APP_NAME=go-traefik

RUN apk update && apk add --no-cache git && apk add --no-cache bash && apk add build-base

RUN mkdir -p $GOPATH/src/$APP_NAME

WORKDIR $GOPATH/src/$APP_NAME

COPY . $GOPATH/src/$APP_NAME

RUN go mod tidy

RUN go build -o main $GOPATH/src/$APP_NAME/cmds/app/main.go

CMD $GOPATH/src/$APP_NAME/main