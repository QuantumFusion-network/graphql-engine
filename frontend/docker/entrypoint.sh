#!/bin/sh

echo "Injecting environment variables into HTML files..."

# Перебор всех HTML файлов и подстановка переменных
for file in $(find /usr/share/nginx/html -type f -name "*.html"); do
  echo "Processing $file"
  sed -i "s|%NX_DATA_API_URL%|${NX_DATA_API_URL}|g" "$file"
done

echo "Starting Nginx..."
exec nginx -g "daemon off;"
