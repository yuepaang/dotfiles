function! s:install_minpac() abort
    echo 'Installing minpac...'
    let cmd =
                \ "git clone https://github.com/k-takata/minpac.git ./pack/minpac/opt/minpac"
    let out = system(cmd)
    if v:shell_error
        echohl ErrorMsg | echom 'Error!: ' . out | echohl None
    else
        echo 'minpac was installed to ~/.config/nvim/pack'
    endif
endfunction

let s:minpac_repo_path = expand('~/.config/nvim/pack')

if !isdirectory(s:minpac_repo_path)
    call s:install_minpac()
endif

function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})

    call minpac#add('ncm2/ncm2')
    call minpac#add('roxma/nvim-yarp')
    call minpac#add('ncm2/ncm2-bufword')
    call minpac#add('ncm2/ncm2-path')
    call minpac#add('ncm2/ncm2-ultisnips')
    call minpac#add('filipekiss/ncm2-look.vim')
    call minpac#add('ncm2/ncm2-tagprefix')
    call minpac#add('ncm2/ncm2-gtags')
    call minpac#add('ncm2/ncm2-tagprefix')
    call minpac#add('ncm2/ncm2-github')
    call minpac#add('ncm2/ncm2-racer')
    call minpac#add('ncm2/ncm2-jedi')
    call minpac#add('ncm2/ncm2-pyclang')
    call minpac#add('ncm2/ncm2-html-subscope')
    call minpac#add('ncm2/ncm2-markdown-subscope')
    call minpac#add('ncm2/ncm2-jedi')
    call minpac#add('yuki-ycino/ncm2-dictionary')
    call minpac#add('fgrsnau/ncm-otherbuf')
    call minpac#add('ncm2/nvim-typescript', {'do': { -> system('./install.sh')}})

    call minpac#add('Shougo/neco-vim')
    call minpac#add('ncm2/ncm2-vim')
    call minpac#add('Shougo/neco-syntax')
    call minpac#add('ncm2/ncm2-syntax')
    call minpac#add('Shougo/neoinclude.vim')
    call minpac#add('ncm2/ncm2-neoinclude')
    call minpac#add('Shougo/neosnippet-snippets')
    call minpac#add('Shougo/neosnippet.vim')
    call minpac#add('ncm2/ncm2-neosnippet')

    call minpac#add('prabirshrestha/async.vim')
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('ncm2/ncm2-vim-lsp')

    call minpac#add('jiangmiao/auto-pairs')

    call minpac#add('scrooloose/nerdtree')
    call minpac#add('Xuyuanp/nerdtree-git-plugin')
    call minpac#add('low-ghost/nerdtree-fugitive')
    call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')
    call minpac#add('ivalkeen/nerdtree-execute')

    call minpac#add('w0rp/ale')

    call minpac#add('scrooloose/nerdcommenter')

    " class module
    call minpac#add('majutsushi/tagbar')

    " Automatically sort python imports
    call minpac#add('fisadev/vim-isort')

    " Search results counter
    call minpac#add('vim-scripts/IndexedSearch')

    call minpac#add('junegunn/fzf', {'do': { -> system('./install --all')}})
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('fszymanski/fzf-quickfix')

    " Better language pack
    call minpac#add('sheerun/vim-polyglot')

    call minpac#add('iamcco/markdown-preview.nvim', {'do': { -> system("cd app & yarn install")}})

    call minpac#add('Shougo/echodoc.vim')
    call minpac#add('heavenshell/vim-pydocstring')

    call minpac#add('SirVer/ultisnips')
    call minpac#add('honza/vim-snippets')

    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-rhubarb')
    call minpac#add('rhysd/git-messenger.vim')

    call minpac#add('mg979/vim-visual-multi')

    call minpac#add('junegunn/vim-easy-align')

    call minpac#add('sjl/badwolf')
    call minpac#add('flrnprz/plastic.vim')
    call minpac#add('jacoborus/tender.vim')
    call minpac#add('junegunn/seoul256.vim')
    call minpac#add('ayu-theme/ayu-vim')

    call minpac#add('junegunn/goyo.vim')
    call minpac#add('junegunn/limelight.vim')

    call minpac#add('itchyny/lightline.vim')
    call minpac#add('maximbaz/lightline-ale')
    call minpac#add('ryanoasis/vim-devicons')

    call minpac#add('machakann/vim-highlightedyank')

endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

if has('mac')
    let g:python3_host_prog='/usr/local/bin/python3'
else
    let g:python3_host_prog='/usr/bin/python3'
endif

" ale {
"  yapf python
    let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'python': ['autopep8'],
        \   'javascript': ['eslint', 'prettier'],
        \   'typescript': ['tslint', 'prettier'],
        \   'css': ['prettier'],
        \   'c': ['clang-format'],
        \   'cpp': ['clang-format'],
        \   'rust': ['rustfmt'],
        \   'json': ['fixjson'],
        \}
    " Set this variable to 1 to fix files when you save them.
    let g:ale_fix_on_save = 1

    let g:ale_linters = {
        \       'c': ['cppcheck', 'flawfinder'],
        \       'cpp': ['cppcheck', 'flawfinder'],
        \       'css': ['stylelint'],
        \       'html': ['tidy'],
        \       'json': [],
        \       'markdown': ['languagetool'],
        \       'python': ['flake8', 'mypy', 'pydocstyle', 'pylint'],
        \       'rust': ['cargo'],
        \       'sh': ['shellcheck'],
        \       'text': ['languagetool'],
        \       'vim': ['vint'],
        \       'go': ['gopls'],
        \}

    "查看上一个错误
    nnoremap <silent> [a :ALEPrevious<CR>
    "查看下一个错误
    nnoremap <silent> ]a :ALENext<CR>
    "自定义error和warning图标
    let g:ale_sign_error="\uf05e"
    let g:ale_sign_warning="\uf071"
    let g:ale_sign_column_always=1

    "显示Linter名称,出错或警告等相关信息
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    " 光标移动到错误的地方时立即显示错误
    let g:ale_echo_delay = 0

    autocmd ColorScheme * highlight ALEErrorSign ctermfg=red ctermbg=18
    highlight ALEErrorSign ctermbg=NONE ctermfg=red
    highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
" }

" auto-pairs
	function! Help_auto_pairs()
	    echo '插入模式下：'
	    echo '<A-z>p            toggle auto-pairs'
	    echo '<A-n>             jump to next closed pair'
	    echo '<A-Backspace>     delete without pairs'
	    echo '<A-z>[key]        insert without pairs'
	endfunction

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
" }

" vim-devicons {
	let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:DevIconsEnableFoldersOpenClose = 1
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[''] = "\uf15b"
	let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
	let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" }
" echodoc {
	let g:echodoc#enable_at_startup = 1
	let g:echodoc#type = 'signature'
" }

" fugitive {
	nmap df :Gdiff<CR>
" }

" fzf {
	command! -bang -nargs=? -complete=dir Files
	  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

	command! -bang -nargs=* Ag
	  \ call fzf#vim#ag(<q-args>,
	  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
	  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
	  \                 <bang>0)

	nnoremap <C-p> :Files<CR>


    let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit' }
    let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'Type'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Character'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }
" }


" lightline {
    let g:lightline = {
        \ 'colorscheme': 'seoul256',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste'],
        \             [ 'fugitive', 'filename' ],
        \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
        \           ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ]
        \            ]
        \ },
        \ 'inactive' : {
        \   'left': [ [ 'mode' ],
        \             [ 'filename' ]
        \           ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'filetype' ]
        \            ]
        \ },
        \ 'tabline' : {
        \   'left'  : [ [ 'tabs' ] ],
        \   'right' : [ [], [ 'session' ] ]
        \ },
        \ 'tab' : {
        \   'active' : [ 'tabnum', 'filename', 'fticon', 'modified' ],
        \   'inactive' : [ 'tabnum', 'filename', 'fticon', 'modified' ]
        \ },
        \ 'tab_component_function' : {
        \     'fticon'  : 'LightLineTabFiletypeIcon'
        \ },
        \ 'component_function' : {
        \   'fugitive'         : 'LightLineFugitive',
        \   'readonly'         : 'LightLineReadonly',
        \   'modified'         : 'LightLineModified',
        \   'filename'         : 'LightLineFilename',
        \   'fileformat'       : 'LightLineFileformat',
        \   'filetype'         : 'LightLineFiletype',
        \   'fileencoding'     : 'LightLineFileencoding',
        \   'mode'             : 'LightLineMode',
        \   'session'          : 'LightLineSession',
        \ },
        \ 'component_expand' : {
        \   'linter_checking': 'lightline#ale#checking',
        \   'linter_warnings': 'lightline#ale#warnings',
        \   'linter_errors': 'lightline#ale#errors',
        \   'linter_ok': 'lightline#ale#ok',
        \ },
        \ 'component_type' : {
        \   'linter_checking': 'middle',
        \   'linter_warnings': 'warning',
        \   'linter_errors': 'error',
        \   'linter_ok': 'middle',
        \ },
        \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
        \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
        \ }

    let g:plugin_filetypes = 'help\|unite\|vimfiler\|gundo'

    function! LightLineSession()
    return fnamemodify(v:this_session, ':t:r')
    endfunction

    function! LightLineModified()
    return &ft =~# g:plugin_filetypes ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightLineReadonly()
    return &ft !~# g:plugin_filetypes && &readonly ? '' : ''
    endfunction

    function! LightLineFugitive()
    if &ft !~# g:plugin_filetypes && exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
    endfunction

    function! LightLineFilename()
    let fname = expand('%:t')
    return &ft == 'tagbar' ? '' :
            \ &ft == 'gundo' ? '' :
            \ fname == '__Gundo_Preview__' ? '' :
            \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
            \ &ft == 'unite' ? unite#get_status_string() :
            \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
            \ ('' != fname ? fname : '[No Name]') .
            \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    endfunction

    function! LightLineFileformat()
    return winwidth(0) > 70 && &ft !~# g:plugin_filetypes ? WebDevIconsGetFileFormatSymbol() : ''
    endfunction

    function! LightLineFiletype()
    return winwidth(0) > 70 && &ft !~# g:plugin_filetypes ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    endfunction

    function! LightLineTabFiletypeIcon(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let fn = expand('#'.buflist[winnr - 1].':t')
    return strlen(fn) ? WebDevIconsGetFileTypeSymbol(fn) : ''
    endfunction

    function! LightLineFileencoding()
    return winwidth(0) > 70 && &ft !~# g:plugin_filetypes ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! LightLineMode()
    let fname = expand('%:t')
    return &ft == 'tagbar' ? 'Tagbar' :
            \ &ft == 'gundo' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ &ft == 'unite' ? 'Unite' :
            \ &ft == 'vimfiler' ? 'VimFiler' :
            \ winwidth(0) > 20 ? lightline#mode() : ''
    endfunction

    let g:lightline#ale#indicator_checking = "\uf110"
    let g:lightline#ale#indicator_warnings = "\uf071 "
    let g:lightline#ale#indicator_errors = "\uf05e "
    let g:lightline#ale#indicator_ok = "\uf00c"
" }


" MarkdownPreview {
    let g:mkdp_auto_start=1
    let g:mkdp_auto_close=1

    nmap <silent> <F5> <Plug>MarkdownPreview
    imap <silent> <F5> <Plug>MarkdownPreview
    nmap <silent> <F6> <Plug>MarkdownPreviewStop
    imap <silent> <F6> <Plug>MarkdownPreviewStop
" }

" ncm2_ultisnips {
    inoremap <silent> <expr> <C-j> ncm2_ultisnips#expand_or("\<CR>", 'n')
    " c-j c-k for moving in snippet
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
    " let g:UltiSnipsExpandTrigger            = '<A-z>``l'
    let g:UltiSnipsRemoveSelectModeMappings = 0
" }


" ncm2 {
    " enable ncm2 for all buffer
    " let g:ncm2#auto_popup=1
    augroup ncm2_enable_for_buffer
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END

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

    let g:ncm2_pyclang#library_path = '/usr/lib'

    " neosnippets
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    "smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                "\ '\<Plug>(neosnippet_expand_or_jump)' : '\<TAB>'


    " Expand snippet when you hit enter on an entry
    inoremap <silent> <expr> <CR> ncm2_neosnippet#expand_or("\<CR>", 'n')
" }

" ncm2-look {
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
" }

" neovim {
    let g:mapleader="\<SPACE>"
    let g:maplocalleader=","

    " Appearance
    set number
    set relativenumber
    set ruler
    set cursorline
    set scrolloff=10
    set updatetime=300
    set background=dark
    set noshowmode
    set laststatus=2
    set cmdheight=2
    set shortmess+=I
    set colorcolumn=79
    set title

    " Clear current-search highlighting by hitting <CR> in normal mode.
    nnoremap <silent> <CR> :nohlsearch<CR><CR>

    " silent! set number relativenumber background=dark display=lastline,uhex wrap wrapmargin=0 guioptions=ce key=
    " silent! set noshowmatch matchtime=1 noshowmode shortmess+=I cmdheight=2 cmdwinheight=10 showbreak=
    " silent! set noshowcmd noruler rulerformat= laststatus=2 statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
    " silent! set title titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=1
    " silent! set cursorline nocursorcolumn colorcolumn=80 concealcursor=nvc conceallevel=0 norelativenumber
    " silent! set list listchars=tab:>\ ,nbsp:_ synmaxcol=3000 ambiwidth=double breakindent breakindentopt=
    " silent! set startofline linespace=0 whichwrap=b,s scrolloff=0 sidescroll=0
    " silent! set equalalways nowinfixwidth nowinfixheight winminwidth=3 winminheight=3 nowarn noconfirm
    " silent! set fillchars=vert:\|,fold:\  eventignore= helplang=en viewoptions=options,cursor virtualedit=

    " Editing
    silent! set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
    silent! set smartindent autoindent shiftround shiftwidth=4 expandtab tabstop=4 smarttab softtabstop=4
    silent! set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
    silent! set textwidth=0 backspace=indent,eol,start nrformats=hex formatoptions=cmMj nojoinspaces
    silent! set nohidden autoread noautowrite noautowriteall nolinebreak mouse=a mousehide modeline& modelines&
    silent! set noautochdir write nowriteany writedelay=0 verbose=0 verbosefile= notildeop noinsertmode
    silent! set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags
    silent! set tags+=../../../../../../tags,../../../../../../../tags,~/Documents/scala/tags,~/Documents/*/tags tagstack

    " Clipboard
    silent! set clipboard=unnamed,unnamedplus

    " Search
    silent! set wrapscan ignorecase smartcase incsearch hlsearch magic

    " Insert completion
    silent! set complete& completeopt+=menu,menuone,noinsert,noselect infercase pumheight=10 noshowfulltag shortmess+=c

    " Command line
    silent! set wildchar=9 wildmenu wildmode=list:longest wildoptions= wildignorecase cedit=<C-k>
    silent! set wildignore=*.~,*.?~,*.o,*.sw?,*.bak,*.hi,*.pyc,*.out,*.lock suffixes=*.pdf

    " Performance
    silent! set updatetime=300 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw
    silent! set nobackup noswapfile nowritebackup

    " Option
    silent! set signcolumn=yes splitbelow splitright

    syntax enable
    syntax on
    filetype off
    filetype plugin on
    filetype indent on

    set encoding=utf-8 nobomb
    set termencoding=utf-8
    set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
    set fileformats=unix,dos,mac
    scriptencoding utf-8

    set hidden
    set cursorline

    " color {
        " colorscheme plastic
        " colorscheme tender
        " seoul256 (dark):
        "   Range:   233 (darkest) ~ 239 (lightest)
        "   Default: 237
        let g:seoul256_background = 235
        colo seoul256

        " colorscheme ayu
        " let ayucolor="light"
        " let ayucolor="mirage"
        " let ayucolor="dark"

        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        set termguicolors
        set t_Co=256
        hi Conceal guifg=#666666 ctermfg=255 guibg=#282828 ctermbg=235 gui=NONE cterm=NONE

    " }


    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/

    hi Whitespace ctermfg=96 guifg=#725972 guibg=NONE ctermbg=NONE

    " 打开文件自动定位到最后编辑的位置
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
    for f in split(glob('~/.config/nvim/rc/ftplugin/*.vim'), '\n')
        exe 'source' f
    endfor

    " windows
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Don't lose selection when shifting sidewards
    xnoremap <  <gv
    xnoremap >  >gv

    inoremap <c-c> <ESC>

    nmap <leader>g :Goyo<CR>
    nmap <leader>l :Limelight!!<CR>
    xmap <leader>l :Limelight!!<CR>

" }

" nerdcommenter {
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1

    let g:NERDDefaultAlign = 'left'
    let g:NERDCustomDelimiters = {
            \ 'javascript': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' },
            \ 'less': { 'left': '/*', 'right': '*/' }
        \ }

    let g:NERDAltDelims_javascript = 1
    let g:NERDDefaultNesting = 1
" }

" nerdtree {
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
" }


" vim-lsp {

    let g:lsp_signs_enabled = 0
    let g:lsp_diagnostics_enabled = 0
    let g:lsp_diagnostics_echo_cursor = 0
    let g:lsp_signs_hint = {'text': '$'}

    function! s:configure_lsp() abort
        setlocal omnifunc=lsp#complete
        nnoremap <buffer> gd :<C-u>LspDefinition<CR>
        nnoremap <buffer> gh :<C-u>LspHover<CR>
        nnoremap <buffer> gt :<C-u>LspTypeDefinition<CR>
        nnoremap <buffer> gr :<C-u>LspReferences<CR>
        nnoremap <buffer> grn :<C-u>LspRename<CR>

        nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
        nnoremap <buffer> gws :<C-u>LspWorkspaceSymbol<CR>

        nnoremap <buffer> gf :<C-u>LspDocumentFormat<CR>
        vnoremap <buffer> grf :LspDocumentRangeFormat<CR>
        nnoremap <buffer> gi :<C-u>LspImplementation<CR>
    endfunction

    if executable('gopls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ })
        " autocmd FileType go setlocal omnifunc=lsp#complete
        autocmd FileType go call s:configure_lsp()
    endif

    if executable('pyls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
        autocmd FileType python call s:configure_lsp()
    endif

    if executable('typescript-language-server')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
            \ 'whitelist': ['typescript', 'typescript.tsx'],
            \ })
        autocmd FileType typescript call s:configure_lsp()
    endif

    if executable('ccls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'ccls',
            \ 'cmd': {server_info->['ccls']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            \ 'initialization_options': {},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ })
    endif

    if executable('rls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'rls',
            \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
            \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
            \ 'whitelist': ['rust'],
            \ })
    endif

" }

" Tagbar {

    "" Tagbar
    nmap <silent> <F4> :TagbarToggle<CR>

" }

" vim-isort {
    let g:vim_isort_map = '<C-i>'
    nmap <silent> pi :Isort<CR>
" }

" pydocstring {
    nmap <silent> <C-d> <Plug>(pydocstring)
" }

" vim-easy-aligh {
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
" }
" git-messager {
    nmap <Leader>gm <Plug>(git-messenger)
" }
