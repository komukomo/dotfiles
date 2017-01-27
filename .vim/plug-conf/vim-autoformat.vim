let blacklist =['sh', 'zsh']
autocmd BufWrite * if index(blacklist, &ft) < 0 | :Autoformat
