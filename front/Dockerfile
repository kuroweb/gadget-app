FROM node:14.4.0-alpine

ARG WORKDIR="app"
ARG HOST
ARG PORT
ARG API_KEY
ARG AUTH_DOMAIN
ARG PROJECT_ID
ARG DATABASE_URL
ARG STORAGE_BUCKET
ARG MESSAGE_SENDER_ID
ARG API_BASE_URL
ARG BROWSER_BASE_URL

ENV HOST                  $HOST
ENV PORT                  $PORT
ENV API_KEY               $API_KEY
ENV AUTH_DOMAIN           $AUTH_DOMAIN
ENV PROJECT_ID            $PROJECT_ID
ENV DATABASE_URL          $DATABASE_URL
ENV STORAGE_BUCKET        $STORAGE_BUCKET
ENV MESSAGE_SENDER_ID     $MESSAGE_SENDER_ID
ENV API_BASE_URL          $API_BASE_URL
ENV BROWSER_BASE_URL      $BROWSER_BASE_URL
ENV TZ                    Asia/Tokyo
# ENV NPM_CONFIG_PRODUCTION false
ENV YARN_PRODUCTION       false

WORKDIR ${WORKDIR}

COPY package*.json ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache make gcc g++ python && \
    yarn install && \
    rm -rf /var/cache/apk/*

COPY . .

# RUN yarn run build

EXPOSE ${PORT}