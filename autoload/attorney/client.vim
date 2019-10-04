function! attorney#client#connect(server) abort
  let mode = attorney#util#mode(a:server)
  let ch = sockconnect(mode, a:server, { 'rpc': 1 })
  let target = fnamemodify(argv()[-1], ':p')
  let client = serverstart()
  call rpcrequest(ch, 'nvim_command', printf(
        \ 'call attorney#editor#open("%s", "%s")',
        \ target,
        \ client,
        \))
  endfunction
