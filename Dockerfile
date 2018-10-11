FROM elixir:alpine

MAINTAINER Michał Kalbarczyk "fazibear@gmail.com"

RUN apk add git bash

RUN adduser -D -u 9000 app

RUN mkdir -p /usr/src/app
COPY . /usr/src/app/codeclimate
WORKDIR /usr/src/app

RUN chown -R app:app /usr/src/app
USER app

ENV MIX_ENV prod

RUN mix local.hex --force

RUN git clone https://github.com/michalmuskala/jason
RUN cd jason && git checkout tags/v1.1.1
RUN cd jason && MIX_ENV=prod mix deps.get --force
RUN cd jason && MIX_ENV=prod mix archive.build --force
RUN cd jason && MIX_ENV=prod mix archive.install --force

RUN git clone https://github.com/rrrene/bunt
RUN cd bunt && git checkout tags/v0.2.0
RUN cd bunt && MIX_ENV=prod mix deps.get --force
RUN cd bunt && MIX_ENV=prod mix archive.build --force
RUN cd bunt && MIX_ENV=prod mix archive.install --force

RUN git clone https://github.com/fazibear/credo
RUN cd credo && git checkout codeclimate
RUN cd credo && MIX_ENV=prod mix deps.get --force
RUN cd credo && MIX_ENV=prod mix archive.build --force
RUN cd credo && MIX_ENV=prod mix archive.install --force

RUN cd codeclimate && MIX_ENV=prod mix deps.get --force
RUN cd codeclimate && MIX_ENV=prod mix archive.build --force
RUN cd codeclimate && MIX_ENV=prod mix archive.install --force

VOLUME /code
#WORKDIR /code

CMD mix code_climate /code
