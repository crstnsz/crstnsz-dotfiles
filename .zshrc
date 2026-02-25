# Caminho para o Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Tema (O 'robbyrussell' é o mais rápido, mas 'agnoster' é visual)
ZSH_THEME="robbyrussell"

# Melhores Plugins (Equilíbrio entre poder e performance)
# zsh-syntax-highlighting e zsh-autosuggestions devem ser instalados à parte
plugins=(
    git 
    docker 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    extract
    sudo
)

source $ZSH/oh-my-zsh.sh

# Carregar arquivos modulares
[[ -f ~/zsh/exports.zsh ]] && source ~/zsh/exports.zsh
[[ -f ~/zsh/aliases.zsh ]] && source ~/zsh/aliases.zsh
[[ -f ~/zsh/functions.zsh ]] && source ~/zsh/functions.zsh

# Correção para Git Bash no Windows (evita lentidão em pastas de rede)
if [[ "$OSTYPE" == "msys" ]]; then
    __git_ps1_show_upstream_config="auto"
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Adiciona [usuário@máquina] antes do prompt do robbyrussell
PROMPT='%n@%m %{$fg_bold[cyan]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}'