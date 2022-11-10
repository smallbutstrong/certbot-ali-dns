FROM golang:1.18.8-alpine  AS build
RUN apk add --no-cache git make musl-dev

RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

RUN  mkdir -p $GOPATH/src/github.com/aliyun && \
     cd $GOPATH/src/github.com/aliyun && \
     git clone http://github.com/aliyun/aliyun-cli.git && \
     git clone http://github.com/aliyun/aliyun-openapi-meta.git && \
     cd aliyun-cli && \
     make install

## Deploy
FROM certbot/certbot 
COPY --from=build /usr/local/bin/aliyun /usr/local/bin/aliyun
COPY ./alidns.sh /usr/local/bin/alidns
