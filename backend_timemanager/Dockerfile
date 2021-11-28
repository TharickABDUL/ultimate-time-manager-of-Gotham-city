FROM elixir:latest

RUN apt-get update

RUN apt-get install -y postgresql-client

COPY . /app/backend

WORKDIR /app/backend

RUN mix local.hex --force

RUN mix archive.install hex phx_new

RUN mix local.rebar --force

RUN mix deps.get

RUN mix compile

CMD [ "./entrypoint.sh" ]