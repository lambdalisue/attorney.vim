function! s:find_mode(address) abort
  return a:address =~# '^\%(\%(\d\{1,3}\.\)\{3}\d\{1,3}\)\?:\d\+'
        \ ? 'tcp'
        \ : 'pipe'
endfunction

call rpcrequest(
      \ sockconnect('pipe', $NVIM_LISTEN_ADDRESS, { 'rpc': 1 }),
      \ 'nvim_command',
      \ printf(
      \   'call attorney#client#open("%s", "%s")',
      \   fnamemodify(argv()[-1], ':p'),
      \   serverstart(),
      \ ),
      \)
