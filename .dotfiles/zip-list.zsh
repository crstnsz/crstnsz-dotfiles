zip-list() {
    local cake_project="$HOME/.dotfiles/tasks/build.csproj"
    
    local path="${1:a}"

    if [[ ! -f "$cake_project" ]]; then
        echo "❌ Arquivo build.cake não encontrado em $cake_project"
        return 1
    fi
    
    dotnet run --project "$cake_project" --verbosity quiet -- --target="ListarZip" --Path="$path"
}