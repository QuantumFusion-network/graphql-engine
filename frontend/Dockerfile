FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock ./

COPY .env /app/.env

COPY tools/ ./tools/

RUN yarn cache clean 

RUN yarn install --ignore-engines

COPY . .

ARG NODE_ENV=production
ARG NX_CDN_ASSETS=false
ARG NX_ENABLE_TELEMETRY=false
ARG NX_URL_PREFIX=/
ARG NX_DATA_API_URL=http://localhost:8080
ARG NX_SERVER_VERSION=v1.0.0
ARG NX_CONSOLE_MODE=server
ARG NX_HASURA_CONSOLE_TYPE=oss

ENV NODE_ENV=${NODE_ENV} \
    NX_CDN_ASSETS=${NX_CDN_ASSETS} \
    NX_ENABLE_TELEMETRY=${NX_ENABLE_TELEMETRY} \
    NX_URL_PREFIX=${NX_URL_PREFIX} \
    NX_DATA_API_URL=${NX_DATA_API_URL} \
    NX_SERVER_VERSION=${NX_SERVER_VERSION} \
    NX_CONSOLE_MODE=${NX_CONSOLE_MODE} \
    NX_HASURA_CONSOLE_TYPE=${NX_HASURA_CONSOLE_TYPE}

RUN echo "NX_DATA_API_URL=${NX_DATA_API_URL}"

RUN export $(cat /app/.env | xargs) && yarn build:ce --verbose

FROM nginx:1.25-alpine

RUN apk add --no-cache gettext
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist/apps/console-ce /usr/share/nginx/html


RUN chmod -R 755 /usr/share/nginx/html && chown -R nginx:nginx /usr/share/nginx/html

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
