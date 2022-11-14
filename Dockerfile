FROM golang:alpine

ENV FOLDER_APP_NAME=go-traefik

RUN apk update && apk add --no-cache git && apk add --no-cache bash && apk add build-base

RUN mkdir -p $GOPATH/src/$FOLDER_APP_NAME

WORKDIR $GOPATH/src/$FOLDER_APP_NAME

COPY . $GOPATH/src/$FOLDER_APP_NAME

RUN go mod tidy

RUN go build -o main $GOPATH/src/$FOLDER_APP_NAME/cmds/app/main.go

CMD $GOPATH/src/$FOLDER_APP_NAME/main