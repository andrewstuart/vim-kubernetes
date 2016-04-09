
if exists("g:loaded_kube") || &cp || v:version < 700
  finish
endif
let g:loaded_kube = 1

function! s:KubeApply()
  " Using stdin so this can possibly be switched to buffer contents
  let cmd = "kubectl apply -f - < " . expand("%")

  let out = system(cmd)

  if v:shell_error
    echo "error applying file " . out
  else
    echo "Successfully applied updates: " . out
  endif

endfunction

command! KubeApply call s:KubeApply()
