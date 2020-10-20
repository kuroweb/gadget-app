FROM node:14.4.0-alpine

ARG WORKDIR
ARG CONTAINER_PORT
ARG API_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0 \
    API_URL=${API_URL} \
    NPM_CONFIG_PRODUCTION=false

# ENV check
RUN echo ${HOME}
RUN echo ${CONTAINER_PORT}
RUN echo ${API_URL}

WORKDIR ${HOME}

#COPY package*.json ./

# 追加
#RUN apk update && \
#    apk upgrade && \
#    apk add --no-cache make gcc g++ python && \
    # yarn installの記載場所を移動
#    yarn install

#COPY . .

#RUN yarn run build

EXPOSE ${CONTAINER_PORT}