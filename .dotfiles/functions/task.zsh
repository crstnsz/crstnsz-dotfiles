coreflags() {
  dotnet cake "$HOME/.dotfiles/tasks/coreflags.cake" --Path="$(realpath "$1")"
}