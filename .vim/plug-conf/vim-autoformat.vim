let blacklist =['sh']
autocmd BufWrite * if index(blacklist, &ft) < 0 | :Autoformat
