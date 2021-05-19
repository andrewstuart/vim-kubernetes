" Set filetype for ~/.kube/config
autocmd BufRead,BufNewFile */.kube/config set filetype=yaml

" autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl set filetype=yaml.gotexttmpl

" Detect kubectl get X -oyaml | vim (no file)
function s:DetectKubernetes() abort
  if did_filetype() || &ft != ''
    return
  endif
  let l:first_line = getline(1)
  if l:first_line =~# '^\(kind\|apiVersion\): '
    set filetype=yaml
  endif
endfunction
autocmd BufNewFile,BufRead,BufEnter * call s:DetectKubernetes()

function HelmSyntax()
  set filetype=yaml
  unlet b:current_syntax
  syn include @yamlGoTextTmpl syntax/gotexttmpl.vim
  let b:current_syntax = "yaml"
  syn region goTextTmpl start=/{{/ end=/}}/ contains=@gotplLiteral,gotplControl,gotplFunctions,gotplVariable,goTplIdentifier containedin=ALLBUT,goTextTmpl keepend
  hi def link goTextTmpl PreProc
endfunction
augroup helm_syntax
  autocmd!
  autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl call HelmSyntax()
augroup END
