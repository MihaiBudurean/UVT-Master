docker compose up -d
sleep 1
docker exec -it $(docker ps -aqf "name=DC1N1") cqlsh
