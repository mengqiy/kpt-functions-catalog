FROM docker

# Install bash
RUN apk add --no-cache bash

# Install golang
COPY --from=golang:1.15-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

# Install node and npm
RUN apk add --no-cache --update nodejs npm
