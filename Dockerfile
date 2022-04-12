FROM alpine:latest

RUN apk add curl
WORKDIR /uploader
COPY . /uploader

CMD ["/bin/sh", "upload.sh"]
