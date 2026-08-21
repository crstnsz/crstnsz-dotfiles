# Caminho para o Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema (O 'robbyrussell' é o mais rápido, mas 'agnoster' é visual)
ZSH_THEME="robbyrussell"

# Melhores Plugins (Equilíbrio entre poder e performance)
# zsh-syntax-highlighting e zsh-autosuggestions devem ser instalados à parte
plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    extract
    sudo
    dotnet
)

# Verifica se o comando 'docker' existe no sistema
if (( $+commands[docker] )); then
    plugins+=(docker)
fi

source $ZSH/oh-my-zsh.sh

if [ -f "$HOME/.env" ]; then
    set -a
    source "$HOME/.env"
    set +a
fi

# Carregar arquivos modulares
if [ -d "$HOME/.dotfiles" ]; then
  for file in "$HOME/.dotfiles"/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi

# Carregar configurações locais
if [ -d "$HOME/.zsh.local" ]; then
    source "$HOME/.zsh.local"
fi

# Correção para Git Bash no Windows (evita lentidão em pastas de rede)
if [[ "$OSTYPE" == "msys" ]]; then
    __git_ps1_show_upstream_config="auto"
fi

if [ -x "/usr/bin/git" ]; then
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
elif [ -x "/mingw64/bin/git" ]; then
    alias config='/mingw64/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
fi


# Adiciona [usuário@máquina] antes do prompt do robbyrussell
PROMPT='%n@%m %{$fg_bold[cyan]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}'

[ -f "/home/crstnsz/.ghcup/env" ] && . "/home/crstnsz/.ghcup/env" # ghcup-env

if [[ -n "$DOTNET_INSTALL_DIR" ]]; then
  PATH="$DOTNET_INSTALL_DIR/tools:$PATH"
fi

# Added by Antigravity CLI installer
export PATH="/home/crstnsz/.local/bin:$PATH"
