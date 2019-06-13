" ncm2_ultisnips
inoremap <silent> <expr> <C-y> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"

" ncm2_neosnippet
inoremap <silent> <expr> <CR> ncm2_neosnippet#expand_or("\<CR>", 'n')

" enable ncm2 for all buffer
augroup ncm2_enable_for_buffer
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END
" note that must keep noinsert in completeopt, the others is optional

" Enable && Disable Globally
let g:ncm2_look_enabled = 0
" Enable Command
function! Func_ToggleNcm2Look()
    if g:ncm2_look_enabled == 1
        let g:ncm2_look_enabled = 0
    elseif g:ncm2_look_enabled == 0
        let g:ncm2_look_enabled = 1
    endif
endfunction
" Symbol
let g:ncm2_look_mark = "\uf02d"

augroup NCM2_Config
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd TextChangedI * call ncm2#auto_trigger()  " enable auto complete for `<backspace>`, `<c-w>` keys
    autocmd VimEnter * inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
augroup END

set completeopt=noinsert,menuone,noselect
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Plug>(ncm2_manual_trigger)\<C-n>"
inoremap <expr> <up> pumvisible() ? "\<C-y>\<up>" : "\<up>"
inoremap <expr> <down> pumvisible() ? "\<C-y>\<down>" : "\<down>"
inoremap <expr> <left> pumvisible() ? "\<C-y>\<left>" : "\<left>"
inoremap <expr> <right> pumvisible() ? "\<C-y>\<right>" : "\<right>"
imap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
imap <expr> <C-z> pumvisible() ? "\<C-e>" : "\<C-z>"

let g:AutoPairsMapCR=0

inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>

" example
imap <expr> <CR> (pumvisible() ? "\<C-Y>\<Plug>(MyCR)" : "\<Plug>(MyCR)")
