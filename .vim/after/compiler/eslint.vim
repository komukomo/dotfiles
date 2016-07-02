" if exists('current_compiler')
" finish
" endif
let current_compiler = 'eslint'

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

function! ParentDir(path)
    let ccc = '/'. join(split(a:path, '/')[:-2], '/')
    return ccc 
endfunction

function! LintAtDir(root)
    let l:lintPath = substitute(a:root, '\n\=$','/','').'*eslint*'
    return substitute(glob(l:lintPath), '\n.*','','g')
endfunction

function! GetLintOpt()
    let l:dir = expand('%:p:h')
    let l:repoRoot = system('hg root')
    let l:lintOpt = '-f\ unix'
    while (l:repoRoot !=# l:dir) && (l:dir !=# '/')
        let l:optfile = LintAtDir(l:dir)
        if !empty(l:optfile)
            let l:lintOpt = '-c\ '.l:optfile
            break
        endif
        let l:dir = ParentDir(l:dir)
    endwhile
    return l:lintOpt
endfunction

let s:lintopt = GetLintOpt()
exe 'CompilerSet makeprg=eslint\ %\ '. s:lintopt
"CompilerSet errorformat=%f(%l):%m
