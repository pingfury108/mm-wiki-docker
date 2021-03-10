FROM golang:1.14.1-alpine
ENV TZ=Asia/Shanghai
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
    && apk add --no-cache  git tzdata

WORKDIR /app
RUN git clone https://github.com/phachon/mm-wiki.git
RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct
WORKDIR /app/mm-wiki
RUN ./build.sh

FROM alpine:3.12
ENV TZ=Asia/Shanghai
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
    && apk add --no-cache tzdata
COPY --from=0 /app/mm-wiki/release /mm-wiki
COPY ./docker-entrypoint.sh /mm-wiki/

EXPOSE 8090

CMD [ "/mm-wiki/docker-entrypoint.sh" ]
