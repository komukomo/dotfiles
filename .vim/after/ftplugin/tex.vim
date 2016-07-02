"autocmd BufNewFile *.tex 0r ~/.vim/ftplugin/template/tex.txt
"
set dictionary=$HOME/.vim/ftplugin/dict/tex.dict


inoremap <C-\> <space>$$<space><left><left>
inoremap \[ <CR>\[<CR>\]<C-O><S-O>
noremap <buffer> <F5> :w<CR>:!make && make clean<CR>
noremap <buffer> <F6> :!xdg-open %<.pdf<CR>
noremap <buffer> <F7> 0i%<ESC>j
