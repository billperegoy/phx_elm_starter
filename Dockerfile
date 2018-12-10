# Alias this container as builder:
FROM bitwalker/alpine-elixir-phoenix:1.7.3 as builder

WORKDIR /phx_elm_starter

# Application
COPY . /phx_elm_starter
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix do deps.get, deps.compile
RUN cd assets && npm install

WORKDIR /phx_elm_starter
RUN rm -rf _build/dev/rel/phx_elm_starter/releases/*
RUN mix release --env=prod

### Release

FROM alpine:3.8

# We need bash and openssl for Phoenix
RUN apk upgrade --no-cache && \
    apk add --no-cache bash openssl

ENV MIX_ENV=prod \
    SHELL=/bin/bash

WORKDIR /phx_elm_starter

COPY --from=builder /phx_elm_starter/_build/dev/rel/phx_elm_starter/releases/*/phx_elm_starter.tar.gz .

RUN tar zxf phx_elm_starter.tar.gz && rm phx_elm_starter.tar.gz

CMD ["/phx_elm_starter/bin/phx_elm_starter", "foreground"]
