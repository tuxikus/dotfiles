export def greet [] {
  let greetings_dir = $"($env.HOME)/.config/nushell/greetings"
  let greeting = (ls $greetings_dir | shuffle | first).name
  let greeting_content = (open $greeting | ansi gradient --fgstart '0x40c9ff' --fgend '0xe81cff')

  clear
  print $greeting_content
}

