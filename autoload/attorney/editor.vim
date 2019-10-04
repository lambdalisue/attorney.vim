function! attorney#editor#open(target, client)
  execute g:attorney#editor#opener fnameescape(a:target)
  setlocal bufhidden=wipe
  augroup attorney
    autocmd! * <buffer>
    autocmd BufDelete <buffer> call s:BufDelete()
    autocmd VimLeave * call s:VimLeave()
  augroup END
  let mode = attorney#util#mode(a:client)
  let b:attorney = sockconnect(mode, a:client, { 'rpc': 1 })
endfunction

function! s:BufDelete() abort
  let ch = getbufvar(expand('<afile>'), 'attorney', v:null)
  if ch is# v:null
    return
  endif
  silent! call rpcrequest(ch, 'nvim_command', 'qall')
endfunction

function! s:VimLeave() abort
  let expr = v:dying || v:exiting > 0 ? 'cquit' : 'qall'
  let bufnrs = filter(
        \ range(0, bufnr('$')),
        \ { -> getbufvar(v:val, 'attorney', v:val) isnot# v:val },
        \)
  for n in bufnrs
    silent! call rpcrequest(getbufvar(n, 'attorney'), 'nvim_command', expr)
  endfor
endfunction


let g:attorney#editor#opener = get(g:, 'attorney#editor#opener', 'tabedit')
