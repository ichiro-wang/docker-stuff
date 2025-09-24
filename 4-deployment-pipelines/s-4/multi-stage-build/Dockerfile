# first build stage
FROM ruby:3 AS build-stage

WORKDIR /usr/app

RUN gem install jekyll && \ 
    jekyll new . && \ 
    jekyll build

CMD bundle exec jekyll serve --host 0.0.0.0

# new stage
FROM nginx:1.19-alpine

COPY --from=build-stage /usr/app/_site/ /usr/share/nginx/html