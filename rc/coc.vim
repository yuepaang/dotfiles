let g:coc_global_extensions  = [
    \ 'coc-css',
    \ 'coc-rls',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-yaml',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-snippets',
    \ 'coc-highlight',
    \ 'coc-yaml',
    \ 'coc-vimtex',
    \ 'coc-phpls',
    \ 'coc-pairs',
    \ 'coc-vimlsp',
    \ 'coc-git',
    \ 'coc-ultisnips',
    \ 'coc-neosnippet'
    \ ]

imap <C-j> <Plug>(coc-snippets-expand-jump)

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<C-h>"

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> grn <Plug>(coc-rename)

autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
vmap gf  <Plug>(coc-format-selected)
nmap gf  <Plug>(coc-format-selected)

autocmd FileType json syntax match Comment +\/\/.\+$+
