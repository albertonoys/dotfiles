function bind_bang
	switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function bind_dollar
	switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function cl --description 'Change into directory and inmediately list the content'
  cd $argv; ll
end

function hf --description 'Command history with fuzzy search'
  eval (history | fzf -i)
end

function rgs --description 'Search for files with rg'
    rg --files | rg ".*/.*$argv.*" | sort | rg $argv
end
