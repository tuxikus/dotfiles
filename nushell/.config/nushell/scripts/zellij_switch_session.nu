#!/usr/bin/env nu

let session = (zellij list-sessions -s | tv | str trim)
if ($session == "") {
  return
}

zellij pipe --plugin $"file:($env.HOME)/.local/share/zellij/plugins/zellij-switch-session-pipe.wasm" -- $session
