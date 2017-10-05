FROM elixir:alpine

MAINTAINER Michał Kalbarczyk "fazibear@gmail.com"

RUN adduser -D -u 9000 app

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN chown -R app:app /usr/src/app
USER app

RUN mix local.hex --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile
RUN mix escript.build

VOLUME /code
WORKDIR /code

CMD /usr/src/app/bin/codeclimate_credo
