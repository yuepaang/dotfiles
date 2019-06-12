imap <expr> <C-j> pumvisible() ? "\<Plug>(ncm2_ultisnips_expand_completed)" : "\<C-j>"

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
