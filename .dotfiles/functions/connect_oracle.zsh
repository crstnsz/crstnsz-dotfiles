connect_oracle() {
  if [[ -z "$1" ]]; then
    echo "Uso: connect_oracle <nome_do_container> <usuario>"
    echo "Exemplo: connect_oracle meu_container_oracle system"
    return 1
  fi

  local container="$1"
  shift # Remove o nome do container dos argumentos, mantendo apenas os do sqlplus

  docker exec -it "$container" sqlplus "$2@FREEPDB1"
}
