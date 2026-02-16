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
[[ -f ~/dotfiles/zsh/exports.zsh ]] && source ~/dotfiles/zsh/exports.zsh
[[ -f ~/dotfiles/zsh/aliases.zsh ]] && source ~/dotfiles/zsh/aliases.zsh
[[ -f ~/dotfiles/zsh/functions.zsh ]] && source ~/dotfiles/zsh/functions.zsh

# Correção para Git Bash no Windows (evita lentidão em pastas de rede)
if [[ "$OSTYPE" == "msys" ]]; then
    __git_ps1_show_upstream_config="auto"
fi