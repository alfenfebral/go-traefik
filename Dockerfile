ARG FOLDER_APP_NAME=go-traefik

#----------------------------------
FROM golang:alpine AS builder

ARG FOLDER_APP_NAME

ENV FOLDER_APP_NAME=$FOLDER_APP_NAME

RUN apk update && apk add --no-cache git && apk add --no-cache bash && apk add build-base

RUN mkdir -p $GOPATH/src/$FOLDER_APP_NAME

WORKDIR $GOPATH/src/$FOLDER_APP_NAME

COPY . $GOPATH/src/$FOLDER_APP_NAME

RUN go mod tidy

RUN go build -o main $GOPATH/src/$FOLDER_APP_NAME/cmds/app/main.go

#----------------------------------
FROM alpine:3.16.1

ARG FOLDER_APP_NAME

ENV FOLDER_APP_NAME=$FOLDER_APP_NAME

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /go/src/$FOLDER_APP_NAME/.env .env
COPY --from=builder /go/src/$FOLDER_APP_NAME/main .

CMD ./main