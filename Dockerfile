FROM alpine:latest
# TARGETOS TARGETARCH already set by '--platform'
ARG TARGETOS TARGETARCH 
RUN apk add curl
WORKDIR /uploader
COPY ./charts /uploader/charts/
COPY ./upload.sh /uploader/upload.sh
ENTRYPOINT ["./upload.sh"]
