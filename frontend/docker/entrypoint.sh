#!/bin/sh

echo "Injecting environment variables into HTML files..."

# Перебор всех HTML файлов и подстановка переменных
for file in $(find /usr/share/nginx/html -type f -name "*.html"); do
  echo "Processing $file"
  sed -i \
    -e "s|%NODE_ENV%|${NODE_ENV}|g" \
    -e "s|%NX_CDN_ASSETS%|${NX_CDN_ASSETS}|g" \
    -e "s|%NX_ENABLE_TELEMETRY%|${NX_ENABLE_TELEMETRY}|g" \
    -e "s|%NX_URL_PREFIX%|${NX_URL_PREFIX}|g" \
    -e "s|%NX_DATA_API_URL%|${NX_DATA_API_URL}|g" \
    -e "s|%NX_SERVER_VERSION%|${NX_SERVER_VERSION}|g" \
    -e "s|%NX_CONSOLE_MODE%|${NX_CONSOLE_MODE}|g" \
    -e "s|%NX_HASURA_CONSOLE_TYPE%|${NX_HASURA_CONSOLE_TYPE}|g" \
    "$file"

done

echo "Starting Nginx..."
exec nginx -g "daemon off;"
