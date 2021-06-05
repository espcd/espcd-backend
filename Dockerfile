FROM ruby:3.0.0-alpine

RUN set -x \
    && apk add --no-cache --update \
        build-base \
        linux-headers \
        git \
        postgresql-dev \
        nodejs \
        tzdata

WORKDIR /app

ENV RAILS_ENV=production

EXPOSE 3000

VOLUME /app/storage

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . ./

CMD ["rails", "s", "-b", "0.0.0.0"]
