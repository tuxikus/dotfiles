use ~/.config/nushell/scripts/greeting.nu greet
greet

$env.config.show_banner = false
$env.config.buffer_editor = "hx"

$env.EDITOR = "hx"

$env.Path = ($env.Path | prepend ($env.HOME | path join ".cargo" "bin"))
$env.Path = ($env.Path | prepend ($env.HOME | path join ".local" "bin"))
$env.Path = ($env.Path | prepend ($env.HOME | path join "go" "bin"))
$env.Path = ($env.Path | prepend ("" | path join "/" "opt" "homebrew" "bin"))

mkdir ($nu.data-dir | path join "vendor/autoload")

# init starship
let starship_target = ($nu.data-dir | path join "vendor/autoload/starship.nu")
if not ($starship_target | path exists) {
  starship init nu | save -f starship_target
}

# init zoxide
let zoxide_target = ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
if not ($zoxide_target | path exists) {
  zoxide init --cmd cd nushell | save -f $zoxide_target
}

# init tv
let tv_target = ($nu.data-dir | path join "vendor/autoload/tv.nu")
if not ($tv_target | path exists) {
  tv init nu | save -f $tv_target
}
