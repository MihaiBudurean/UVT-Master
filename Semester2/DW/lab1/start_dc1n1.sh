docker compose up -d DC1N1
docker exec -it $(docker ps -aqf "name=DC1N1") cqlsh
