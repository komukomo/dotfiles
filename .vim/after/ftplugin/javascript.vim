:compiler eslint
autocmd QuickfixCmdPost make copen
"autocmd BufWritePost <buffer> silent make | redraw!
nnoremap <SPACE> :make <CR> redraw!<CR>redraw!<CR>

