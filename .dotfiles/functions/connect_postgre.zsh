connect_postgre() {
  if [[ -z "$1" ]]; then
    echo "Uso: dpsql <nome_do_container> [argumentos_adicionais_psql...]"
    echo "Exemplo: dpsql meu_container_pg -U postgres -d minha_base"
    return 1
  fi

  local container="$1"
  shift # Remove o nome do container dos argumentos, mantendo apenas os do psql

  docker exec -it "$container" psql "$@"
}