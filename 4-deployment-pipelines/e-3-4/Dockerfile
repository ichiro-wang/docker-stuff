# docker in docker (dind) with git ready
FROM docker:25-git

WORKDIR /usr/src/app

COPY builder.sh ./
RUN chmod 755 builder.sh

ENTRYPOINT ["./builder.sh"]