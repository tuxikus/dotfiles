#!/usr/bin/env nu

let tab = (zellij action query-tab-names | tv | str trim)
if ($tab == "") {
  return
}

zellij action go-to-tab-name $tab
