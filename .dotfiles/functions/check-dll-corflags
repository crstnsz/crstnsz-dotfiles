function check-dll-core-flags() {
    local cake_project="$HOME/.dotfiles/tasks/Build.csproj"
    
    # Se o usuário não passou um diretório ($1), usa o diretório atual do terminal (.)
    local folder="${1:a}"

    echo "🔍 Verificando arquivos DLL no diretório: $folder"

    if [[ ! -f "$cake_project" ]]; then
        echo "❌ Arquivo build.cake não encontrado em $cake_project"
        return 1
    fi
    
    dotnet run --project "$cake_project" --verbosity quiet  -- --target="CheckDllArchitecture" --Path="$folder"
}