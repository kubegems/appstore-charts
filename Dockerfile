FROM alpine:latest
# TARGETOS TARGETARCH already set by '--platform'
ARG TARGETOS TARGETARCH 
RUN apk add curl
WORKDIR /uploader
COPY . /uploader/charts/
ENTRYPOINT ["./upload.sh"]
