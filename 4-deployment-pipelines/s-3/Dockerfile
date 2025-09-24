FROM ubuntu:24.04

WORKDIR /myapp

RUN apt-get update && apt-get install -y curl python3
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+x /usr/local/bin/yt-dlp

# create user
RUN useradd -m appuser
# owner of cwd to appuser
RUN chown appuser .
# change to appuser
USER appuser

ENTRYPOINT ["/usr/local/bin/yt-dlp"]