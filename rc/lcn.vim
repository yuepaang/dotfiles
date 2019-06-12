function! Help_Language_Client_neovim()
    echo 'gd        definition'
    echo 'gt        typeDefinition'
    echo 'gI        implementation'
    echo 'gr        references'
    echo 'gR        rename'
    echo 'ga        codeAction'
    echo 'gf        formatting'
endfunction

" Server Register
let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls'],
    \ 'cpp': ['ccls'],
    \ 'objc': ['ccls'],
    \ 'objcpp': ['ccls'],
    \ 'html': ['html-languageserver', '--stdio'],
    \ 'json': ['vscode-json-languageserver', '--stdio'],
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'sh': ['bash-language-server', 'start'],
    \ 'yaml': ['yaml-language-server', '--stdio'],
    \ 'go': ['gopls']
    \ }

augroup LanguageClientAu
    autocmd!
    autocmd User LanguageClientStarted setlocal signcolumn=auto
    autocmd User LanguageClientStopped setlocal signcolumn=auto
    autocmd CursorHold call LanguageClient#textDocument_hover()
    autocmd CursorHold call LanguageClient#textDocument_documentHighlight()
    autocmd CursorMoved call LanguageClient#textDocument_clearDocumentHighlight()
augroup END

let g:LanguageClient_hasSnippetSupport = 1
" AutoStart
let g:LanguageClient_autoStart = 1
" hoverPreview: Never Auto Always
let g:LanguageClient_hoverPreview = 'Always'

" Completion
set omnifunc=LanguageClient#complete
" Formatting
set formatexpr=LanguageClient_textDocument_rangeFormatting()
" Mappings
nnoremap <silent> gd :<C-u>call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gt :<C-u>call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> gI :<C-u>call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> gr :<C-u>call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gR :<C-u>call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> ga :<C-u>call LanguageClient#textDocument_codeAction()<CR>
nnoremap <silent> gf :<C-u>call LanguageClient#textDocument_formatting()<CR>
vnoremap <silent> gf :<C-u>call LanguageClient#textDocument_rangeFormatting()<CR>

let g:LanguageClient_diagnosticsDisplay = {
    \ 1: {
    \ 'name': 'Error',
    \ 'texthl': 'ALEError',
    \ 'signText': "\uf65b",
    \ 'signTexthl': 'ALEErrorSign',
    \ },
    \ 2: {
    \ 'name': 'Warning',
    \ 'texthl': 'ALEWarning',
    \ 'signText': "\uf421",
    \ 'signTexthl': 'ALEWarningSign',
    \ },
    \ 3: {
    \ 'name': 'Information',
    \ 'texthl': 'ALEInfo',
    \ 'signText': "\uf7fb",
    \ 'signTexthl': 'ALEInfoSign',
    \ },
    \ 4: {
    \ 'name': 'Hint',
    \ 'texthl': 'ALEInfo',
    \ 'signText': "\uf68a",
    \ 'signTexthl': 'ALEInfoSign',
    \ },
    \ }

imap <expr> <CR> (pumvisible() ? "\<C-Y>\<Plug>(expand_or_cr)" : "\<CR>")
imap <expr> <Plug>(expand_or_cr) (cm#completed_is_snippet() ? "\<C-U>" : "\<CR>")
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
inoremap <silent> <C-U> <C-R>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<CR>

let settings = json_decode('
            \ {
            \   "yaml": {
            \       "completion": true,
            \       "hover": true,
            \       "validate": true,
            \       "schemas": {
            \           "Kubernetes": "/*"
            \           },
            \       "format": {
            \           "enable": true
            \       }
            \   },
            \   "http": {
            \       "proxyStrictSSL": true
            \}
            \}
            \')

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted call LanguageClient#Notify(
                \ 'workspace/didChangeConfiguration', {'settings': settings})
augroup END

" Goto definition in a split
call LanguageClient#textDocument_definition({'gotoCmd': 'split'})
