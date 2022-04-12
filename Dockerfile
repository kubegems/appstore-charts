FROM alpine:latest
RUN apk add curl
WORKDIR /uploader
COPY . /uploader
ENTRYPOINT ["./upload.sh"]
