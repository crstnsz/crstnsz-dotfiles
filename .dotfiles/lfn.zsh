function lfn() {
    source ~/.dotfiles/functions/$1.zsh
}

function lfnls() {
  # Busca os arquivos e armazena em um array local
  local arquivos=( ~/.dotfiles/functions/**/*.zsh(N) )
  
  # ${arquivos:t} remove todo o caminho das pastas (deixa só o nome.zsh)
  # ${arquivos:r} remove a extensão do arquivo (deixa só o nome)
  # Aplicando os dois juntos:
  print -l ${arquivos:t:r}
}
