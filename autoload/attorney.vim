let s:sep = has('win32') ? '\\' : '/'
let s:root = fnamemodify(expand('<sfile>'), ':p:h:h')
let s:script = resolve(join([s:root, 'script', 'rpcrequest.vim'], s:sep))
let s:EDITOR_SAVED = $EDITOR

function! attorney#EDITOR() abort
  if has('nvim')
    return join([
          \ v:progpath,
          \ '--headless',
          \ '--clean',
          \ '--noplugin',
          \ '-n', '-R',
          \ '-c', shellescape('set runtimepath^='. fnameescape(s:root)),
          \ '-c', shellescape(printf('call attorney#client#connect("%s")', v:servername)),
          \])
  else
    throw 'attorney.vim: Vim is not supported yet.'
  endif
endfunction

function! attorney#apply() abort
  let $EDITOR = attorney#EDITOR()
endfunction

function! attorney#restore() abort
  let $EDITOR = s:EDITOR_SAVED
endfunction
