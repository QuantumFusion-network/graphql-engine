# Create new table
curl -X POST http://localhost:8080/v1/query \
-H "Content-Type: application/json" \
-H "x-hasura-admin-secret: mysecretkey" \
--data '{
"type": "run_sql",
"args": {
"source": "default",
"sql": "CREATE TABLE public.hello_world (id SERIAL PRIMARY KEY, name TEXT);"
}
}'

# Add table to hasura
curl -X POST http://localhost:8080/v1/metadata \
-H "Content-Type: application/json" \
-H "x-hasura-admin-secret: mysecretkey" \
--data '{
"type": "pg_track_table",
"args": {
"source": "default",
"table": {
"schema": "public",
"name": "hello_world"
}
}
}'

# Check tracked tables
curl -X POST http://localhost:8080/v1/graphql \
-H "Content-Type: application/json" \
-H "x-hasura-admin-secret: mysecretkey" \
--data '{"query":"{ __type(name: \"query_root\") { fields { name } } }"}'

# Add new record
curl -X POST http://localhost:8080/v1/query \
-H "Content-Type: application/json" \
-H "x-hasura-admin-secret: mysecretkey" \
--data '{
"type": "run_sql",
"args": {
"source": "default",
"sql": "INSERT INTO public.hello_world (name) VALUES (E'\''test'\'');"
}
}'

# Return all records
curl -X POST http://localhost:8080/v1/graphql \
-H "Content-Type: application/json" \
-H "x-hasura-admin-secret: mysecretkey" \
--data '{"query":"{ hello_world { id, name } }"}'
