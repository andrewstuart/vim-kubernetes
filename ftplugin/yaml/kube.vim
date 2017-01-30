if exists('g:loaded_kube') || &cp || v:version < 700
  finish
endif
let g:loaded_kube = 1

function! s:KubeFileOp(op, dir)
  let cmd = 'kubectl ' . a:op . ' -f '

  let currFileName = expand('%')
  let bufferContents = ""

  if a:dir
    let cmd = cmd . fnamemodify(currFileName, ':h:p')
  else
    " Using stdin so this can possibly be switched to buffer contents
    let cmd = cmd . '-'
    let bufferContents = join(getline(1,'$'), "\n")
  endif

  echo cmd

  let out = system(cmd, bufferContents)

  if v:shell_error
    echo 'error applying file ' . out
  else
    if a:op == 'delete'
      echo 'Successfully deleted resources.' . out
    else
      echo 'Successfully applied updates: ' . out
    endif
  endif
endfunction

command! KubeApply call s:KubeFileOp('apply', 0)
command! KubeDelete call s:KubeFileOp('delete', 0)
command! KubeCreate call s:KubeFileOp('create', 0)

command! KubeApplyDir call s:KubeFileOp('apply', 1)
command! KubeDeleteDir call s:KubeFileOp('delete', 1)
