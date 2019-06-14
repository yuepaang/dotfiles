function! Help_auto_pairs()
    echo '插入模式下：'
    echo '<A-z>p            toggle auto-pairs'
    echo '<A-n>             jump to next closed pair'
    echo '<A-Backspace>     delete without pairs'
    echo '<A-z>[key]        insert without pairs'
endfunction
"}}}
let g:AutoPairsShortcutToggle = '<A-z>p'
let g:AutoPairsShortcutFastWrap = '<A-z>`sadsfvf'
let g:AutoPairsShortcutJump = '<A-n>'
let g:AutoPairsWildClosedPair = ''
let g:AutoPairsMultilineClose = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsMapCh = 0
inoremap <A-z>' '
inoremap <A-z>" "
inoremap <A-z>` `
inoremap <A-z>( (
inoremap <A-z>[ [
inoremap <A-z>{ {
inoremap <A-z>) )
inoremap <A-z>] ]
inoremap <A-z>} }
inoremap <A-Backspace> <Space><Esc><left>"_xa<Backspace>
" imap <A-Backspace> <A-z>p<Backspace><A-z>p
augroup AutoPairsAu
    autocmd!
    " au Filetype html let b:AutoPairs = {"<": ">"}
augroup END

let g:AutoPairsMapCR=0

inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>

" example
imap <expr> <CR> (pumvisible() ? "\<C-Y>\<Plug>(MyCR)" : "\<Plug>(MyCR)")
