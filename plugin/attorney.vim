if exists('g:loaded_attorney')
  finish
endif
let g:loaded_attorney = 1

if get(g:, 'attorney_enable_at_startup', 1)
  call attorney#apply()
endif
