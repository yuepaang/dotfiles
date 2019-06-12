if &compatible
  set nocompatible
endif

if has('mac')
    let g:python3_host_prog='/usr/local/bin/python3'
else
    let g:python3_host_prog='/usr/bin/python3'
endif

" ------------------- Self Configuration -----------------------
for rcfile in split(globpath("~/nvim/rc", "*.vim"), '\n')
    execute('source '.rcfile)
endfor
