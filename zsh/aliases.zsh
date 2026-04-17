# Navegação
alias ..="cd .."
alias ...="cd ../.."

# Listagem (Exige que você tenha o 'exa' ou 'lsd' instalado, se não, use ls)
alias ll="ls -lahF --color=auto"
alias l="ls -CF"

# Git (Os melhores)
alias gs="git status"
alias gaall="git add ."
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# Utilitários
alias cl="clear"
alias reload="source ~/.zshrc"

#kubernetes
alias k="kubectll"


if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Abre o PowerShell puro como Admin
    alias psadmin="powershell.exe -Command \"Start-Process powershell.exe -Verb RunAs\""

    # Abre o PowerShell como Admin já na pasta atual (corrigido)
    alias psadminhere='powershell.exe -Command "Start-Process powershell.exe -ArgumentList '\''-NoExit'\'', '\''-Command'\'', '\''Set-Location -LiteralPath \"$(cygpath -w "$PWD")\"'\'' -Verb RunAs"'
fi