# Dotfiles

My experiment for a minimal, productivity-focused dotfiles setup designed to simplify your workflow without unnecessary complexity.

# Why

After four years of continuously customizing text editors like Emacs and Neovim, experimenting with different window managers and desktop environments, and fine-tuning countless Unix tools, I realized I didn't want to spend all my time configuring.  

# Tools

- 🪟 [Aerospace](https://github.com/nikitabobko/AeroSpace) (MacOS) -> [aerospace.toml](./aerospace/.config/aerospace/aerospace.toml)
- 🪟 [Sway](https://github.com/swaywm/sway) (Linux) -> [config](./sway/.config/sway/config)
- 👻 [Ghostty](https://github.com/ghostty-org/ghostty) -> [config](./ghostty/.config/ghostty/config)
- 🐟 [Fish](https://github.com/fish-shell/fish-shell) -> [config.fish](./fish/.config/fish/config.fish)
- 🧬 [Helix](https://github.com/helix-editor/helix) -> [helix.toml](./helix/.config/helix/config.toml)
- 🧠 [Zellij](https://github.com/zellij-org/zellij) -> [config.kdl](./zellij/.config/zellij/config.kdl)
- 🦆 [Yazi](https://github.com/sxyazi/yazi) -> [yazi.toml](./yazi/.config/yazi/yazi.toml)
- 🔍 [Fuzzel](https://codeberg.org/dnkl/fuzzel) -> [fuzzel.ini](./fuzzel/.config/fuzzel/fuzzel.ini)
- 📦 [Stow](https://www.gnu.org/software/stow)

# Host specific config

```shell
  $ touch ~/.local.fish # put config here
```

# Git config

```shell
  $ touch ~/.gitconfig.personal
  $ touch ~/.gitconfig.work

  # content
  [user]
	  email = <email>
	  name = <user>
```

# Usage

```shell
  $ stow -t $HOME <package>
```
