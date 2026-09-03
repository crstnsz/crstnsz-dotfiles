docker-list()
{
    docker ps --format "table {{.Names}}\t{{.Status}}"
}