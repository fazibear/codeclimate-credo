FROM msaraiva/elixir-dev

RUN adduser -D -u 9000 app

COPY . /usr/src/app
WORKDIR /usr/src/app

RUN chown -R app:app /usr/src/app
USER app
VOLUME /code

RUN mix local.hex --force
RUN mix deps.get
RUN mix deps.compile
RUN mix compile

CMD mix codeclimate
