let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : '✸',
    \ 'Staged'    : '&',
    \ 'Untracked' : '✩',
    \ 'Renamed'   : '➠',
    \ 'Unmerged'  : '⮴',
    \ 'Deleted'   : "\uf6bf",
    \ 'Dirty'     : '✘',
    \ 'Clean'     : '✔',
    \ 'Ignored'   : "\ufb12",
    \ 'Unknown'   : "\uf128"
    \ }

" highlight fullname
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
" highlight folders using exact match
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
"}}}
"}}}
nnoremap <silent> <leader>n :<C-u>NERDTreeToggle<CR>

function! s:nerdtree_mappings() abort
    nnoremap <silent><buffer> ~ :<C-u>NERDTreeVCS<CR>
    nnoremap <silent><buffer> <A-f> :call Nerdtree_Fuzzy_Finder()<CR>
    nnoremap <silent><buffer> <A-g> :call Nerdtree_Grep()<CR>
    nnoremap <silent><buffer> h :call Help_nerdtree()<CR>
    nmap <silent><buffer> <A-e> <C-b>:<C-u>NnnPicker '%:p:h'<CR>
    nmap <silent><buffer> <A-b> <C-b>:<C-u>BufExplorer<CR>
endfunction
augroup NERDTreeAu
    autocmd!
    autocmd FileType nerdtree setlocal signcolumn=no
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd FileType nerdtree call s:nerdtree_mappings()
augroup END
let NERDTreeMinimalUI = 1
let NERDTreeWinSize = 35
let NERDTreeChDirMode = 0
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

function! Nerdtree_Fuzzy_Finder()
    execute 'LeaderfFile'
endfunction
function! Nerdtree_Grep()
    execute 'Leaderf rg'
endfunction
