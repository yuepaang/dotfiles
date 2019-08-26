" File              : init.vim
" Author            : Yue Peng <yuepaang@gmail.com>
" Date              : 2019-07-12 11:01:48
" Last Modified Date: 2019-08-24 21:52:53
" Last Modified By  : Yue Peng <yuepaang@gmail.com>

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

    " Auto-completion {
        function! s:coc_plugins(hooktype, name) abort
            execute 'packadd ' . a:name
            call coc#util#install()
        endfunction

        call minpac#add('https://github.com/neoclide/coc.nvim', {'branch': 'release', 'do': function('s:coc_plugins')})
        call minpac#add('https://github.com/Shougo/neco-vim')
        call minpac#add('https://github.com/neoclide/coc-neco')
        call minpac#add('Shougo/neoinclude.vim')
        call minpac#add('jsfaint/coc-neoinclude')
    " }

    " Linter {
        call minpac#add('w0rp/ale')
    " }

    " Utilities {
        call minpac#add('scrooloose/nerdcommenter')
        call minpac#add('cinuor/vim-header')
        call minpac#add('Shougo/echodoc.vim')
        call minpac#add('heavenshell/vim-pydocstring')
        call minpac#add('itchyny/calendar.vim')
')
    " }

    " tags view {
        call minpac#add('majutsushi/tagbar')
    " }

    " Search {
        call minpac#add('vim-scripts/IndexedSearch')
        call minpac#add('haya14busa/incsearch.vim')  " Better search highlighting
    " }

    " fzf {
        call minpac#add('junegunn/fzf', {'do': { -> system('./install --all')}})
        call minpac#add('junegunn/fzf.vim')
        call minpac#add('fszymanski/fzf-quickfix')
    " }

    " Better language pack {
        call minpac#add('sheerun/vim-polyglot')
    " }

    " MarkdownPreview {
        call minpac#add('iamcco/markdown-preview.nvim', {'do': { -> system("cd app & yarn install")}})
    " }

    " defx {
        call minpac#add('Shougo/defx.nvim')
        call minpac#add('kristijanhusak/defx-git')
        call minpac#add('kristijanhusak/defx-icons')
    " }

    " Snippets {
        call minpac#add('honza/vim-snippets')
    " }

    " Git {
        call minpac#add('tpope/vim-fugitive')
        call minpac#add('tpope/vim-rhubarb')
        call minpac#add('rhysd/git-messenger.vim')
    " }

    " Coding {
        call minpac#add('mg979/vim-visual-multi')
        call minpac#add('junegunn/vim-easy-align')
        call minpac#add('Yggdroot/indentLine')
    " }

    " UI {
        call minpac#add('junegunn/seoul256.vim')
        call minpac#add('cormacrelf/vim-colors-github')
        call minpac#add('nanotech/jellybeans.vim')
        call minpac#add('NLKNguyen/papercolor-theme')
        call minpac#add('morhetz/gruvbox')
        call minpac#add('ayu-theme/ayu-vim')
        call minpac#add('hzchirs/vim-material')
    " }

    " Status Line {
        call minpac#add('itchyny/lightline.vim')
        call minpac#add('maximbaz/lightline-ale')
        call minpac#add('ryanoasis/vim-devicons')
    " }

endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

if has('mac')
    let g:python3_host_prog='/usr/local/bin/python3'
else
    let g:python3_host_prog='/usr/bin/python3'
endif

" ALE {
    let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'python': ['black', 'isort'],
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
        \       'javascript': ['eslint', 'stylelint'],
        \       'jsx': ['eslint', 'stylelint'],
        \       'html': ['tidy'],
        \       'json': [],
        \       'markdown': ['languagetool'],
        \       'python': ['pyflakes'],
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
    let g:ale_echo_delay = 1

    autocmd ColorScheme * highlight ALEErrorSign ctermfg=red ctermbg=18
    highlight ALEErrorSign ctermbg=NONE ctermfg=red
    highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
" }

" vim-devicons {
	let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
	let g:WebDevIconsUnicodeDecorateFolderNodes = 1
	let g:DevIconsEnableFoldersOpenClose = 1
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
	let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[''] = "\uf15b"
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
        \ {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', '#5f5f87'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

    " Floating Windows
    let g:fzf_layout = { 'window': 'call FloatingFZF()' }

    function! FloatingFZF()
        let buf = nvim_create_buf(v:false, v:true)
        call setbufvar(buf, 'number', 'no')

        let height = float2nr(&lines/2)
        let width = float2nr(&columns - (&columns * 2 / 10))
        "let width = &columns
        let row = float2nr(&lines / 3)
        let col = float2nr((&columns - width) / 3)

        let opts = {
                \ 'relative': 'editor',
                \ 'row': row,
                \ 'col': col,
                \ 'width': width,
                \ 'height':height,
                \ }
        let win =  nvim_open_win(buf, v:true, opts)
        call setwinvar(win, '&number', 0)
        call setwinvar(win, '&relativenumber', 0)
    endfunction

    " Files + devicons
    function! Fzf_dev()
        let l:fzf_files_options = ' --preview "rougify {2..-1} | head -'.&lines.'"'

        function! s:files()
            let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
            return s:prepend_icon(l:files)
        endfunction

        function! s:prepend_icon(candidates)
            let l:result = []
            for l:candidate in a:candidates
            let l:filename = fnamemodify(l:candidate, ':p:t')
            let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
            call add(l:result, printf('%s %s', l:icon, l:candidate))
            endfor

            return l:result
        endfunction

        function! s:edit_file(item)
            let l:pos = stridx(a:item, ' ')
            let l:file_path = a:item[pos+1:-1]
            execute 'silent e' l:file_path
        endfunction

        call fzf#run({
                \ 'source': <sid>files(),
                \ 'sink':   function('s:edit_file'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'down':    '40%' ,
                \ 'window': 'call FloatingFZF()'})
    endfunction
" }


" lightline {
    let g:lightline = {
        \ 'colorscheme': 'PaperColor',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste'],
        \             [ 'cocstatus',  'currentfunction', 'fugitive', 'filename' ],
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
        \   'cocstatus'        : 'coc#status',
        \   'currentfunction'  : 'CocCurrentFunction',
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
    let g:mkdp_auto_start=0
    let g:mkdp_auto_close=1

    nmap <silent> <F5> <Plug>MarkdownPreview
    imap <silent> <F5> <Plug>MarkdownPreview
    nmap <silent> <F6> <Plug>MarkdownPreviewStop
    imap <silent> <F6> <Plug>MarkdownPreviewStop
" }

" neovim {
    let g:mapleader="\<SPACE>"
    let g:maplocalleader=","

    " Clear current-search highlighting by hitting <CR> in normal mode.
    nnoremap <silent> <CR> :nohlsearch<CR><CR>

    " To disable conceal regardless of conceallevel setting
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0
    let g:tex_conceal = ""
    let g:vim_markdown_math = 1

    set autowrite
    set autochdir!
    set colorcolumn=80
    set hidden
    set list lcs=tab:\|\ " tab indent guide
    set nocompatible

    " Appearance
    set ruler
    set cursorline
    set scrolloff=10
    set updatetime=300
    set noshowmode
    set laststatus=2
    set cmdheight=2
    set shortmess+=I
    set title

    silent! set number relativenumber background=dark display=lastline,uhex wrap wrapmargin=0 guioptions=ce key=
    " silent! set noshowmatch matchtime=1 noshowmode shortmess+=I cmdheight=2 cmdwinheight=10 showbreak=
    " silent! set noshowcmd noruler rulerformat= laststatus=2 statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
    " silent! set title titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=1
    " silent! set cursorline nocursorcolumn colorcolumn=80 concealcursor=nvc conceallevel=0 norelativenumber
    " silent! set list listchars=tab:>\ ,nbsp:_ synmaxcol=3000 ambiwidth=double breakindent breakindentopt=
    silent! set startofline linespace=0 whichwrap=b,s scrolloff=0 sidescroll=0
    " silent! set equalalways nowinfixwidth nowinfixheight winminwidth=3 winminheight=3 nowarn noconfirm
    silent! set fillchars=vert:\|,fold:\  eventignore= helplang=en viewoptions=options,cursor virtualedit=

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
    silent! set complete& completeopt+=menu,menuone,noinsert,noselect infercase pumheight=15 noshowfulltag shortmess+=c

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


    " color {
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        set termguicolors
        set t_Co=256

        " seoul256 (dark):
        "   Range:   233 (darkest) ~ 239 (lightest)
        "   Default: 237
        " let g:seoul256_background = 236
        " colo seoul256

        colorscheme PaperColor
        set background=dark

        let g:PaperColor_Theme_Options = {
        \   'theme': {
        \     'default': {
        \       'transparent_background': 1
        \     }
        \   },
        \   'language': {
        \     'python': {
        \       'highlight_builtins' : 1
        \     },
        \     'cpp': {
        \       'highlight_standard_library': 1
        \     },
        \     'c': {
        \       'highlight_builtins' : 1
        \     }
        \   }
        \ }

        " colorscheme gruvbox
        " set background=dark
        " let g:gruvbox_contrast_dark = 'hard'
        " let g:gruvbox_italic = 1
        " let g:gruvbox_number_column = 'green'

        " if &diff
        "     colorscheme github
        "     let g:github_colors_soft = 1
        " else

        "     colorscheme ayu
        "     let ayucolor="light"
        " endif

        " Dark
        " set background=dark
        " colorscheme vim-material

        " Palenight
        " let g:material_style='palenight'
        " set background=dark
        " colorscheme vim-material

        " Oceanic
        " let g:material_style='oceanic'
        " set background=dark
        " colorscheme vim-material

        " Light
        " set background=light
        " colorscheme vim-material

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

" Tagbar {

    nmap <silent> <F4> :TagbarToggle<CR>

    let g:tagbar_width=25
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds' : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin' : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
        \ }

" }

" pydocstring {
    nmap <silent> <leader>pd <Plug>(pydocstring)
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

" vim-header {
    let g:header_auto_add_header = 0
    let g:header_field_timestamp_format = '%Y-%m-%d %H:%M:%S'
    let g:header_field_author = 'Yue Peng'
    let g:header_field_author_email = 'yuepaang@gmail.com'
    map <F7> :AddHeader<CR>
" }

" coc.nvim {
    let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-snippets',
        \ 'coc-prettier',
        \ 'coc-eslint',
        \ 'coc-emmet',
        \ 'coc-tsserver',
        \ 'coc-pairs',
        \ 'coc-json',
        \ 'coc-highlight',
        \ 'coc-git',
        \ 'coc-emoji',
        \ 'coc-lists',
        \ 'coc-post',
        \ 'coc-stylelint',
        \ 'coc-yaml',
        \ 'coc-yank',
        \ 'coc-rls',
        \ 'coc-java',
        \ 'coc-vimlsp',
        \ 'coc-browser',
        \ 'coc-tabnine',
        \ 'coc-syntax',
        \ 'coc-tag',
        \ ]

    " mac iterm2 enhance 'coc-imselect'

    " Snippets
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
    let g:coc_status_error_sign = '•'
    let g:coc_status_warning_sign = '•'

    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " use <c-space>for trigger completion
    inoremap <silent><expr> <c-x> coc#refresh()

    " To make <cr> select the first completion item and confirm completion when no item have selected:
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

    " Close preview window when completion is done.
    autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " autocmd! BufWritePre *.js,*.json,*.ts Prettier

    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gt <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nmap <silent> grn <Plug>(coc-rename)

    " Remap for format selected region
    vmap gf  <Plug>(coc-format-selected)
    nmap gf  <Plug>(coc-format-selected)

    " Use K for show documentation in preview window
    nnoremap <silent> gm :call <SID>show_documentation()<CR>

    function! s:show_documentation()
        if &filetype == 'vim'
            execute 'h '.expand('<cword>')
        else
            call CocActionAsync('doHover')
        endif
    endfunction

    autocmd CursorHold * silent call CocActionAsync('highlight')


    augroup mygroup
        autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
            " Update signature help on jump placeholder
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    " vmap <leader>a  <Plug>(coc-codeaction-selected)
    " nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` for fold current buffer
    command! -nargs=? Fold :call CocAction('fold', <f-args>)

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <leader>la  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <leader>lj  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <leader>lk  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <leader>lp  :<C-u>CocListResume<CR>

    autocmd FileType json syntax match Comment +\/\/.\+$+

    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                            \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


    function! CocHighlight() abort
        if &filetype !=# 'markdown'
            call CocActionAsync('highlight')
        endif
    endfunction


    function! CocFloatingLockToggle() abort
        if g:CocFloatingLock == 0
            let g:CocFloatingLock = 1
        elseif g:CocFloatingLock == 1
            let g:CocFloatingLock = 0
        endif
    endfunction

    function! CocHover() abort
        if !coc#util#has_float() && g:CocHoverEnable == 1
            call CocActionAsync('doHover')
            call CocActionAsync('showSignatureHelp')
        endif
    endfunction

    augroup CocAu
        autocmd!
        autocmd CursorHold * silent call CocHover()
        autocmd CursorHold * silent call CocHighlight()
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        autocmd InsertEnter * call coc#util#float_hide()
        autocmd VimEnter * inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
    augroup END
    let g:CocHoverEnable = 0

    highlight CocHighlightText cterm=bold gui=bold
    highlight CocErrorHighlight ctermfg=Gray guifg=#888888
    highlight CocCodeLens ctermfg=Gray guifg=#888888

    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

    autocmd FileType markdown let b:coc_pairs_disabled = ['`']
" }

" Defx {

    augroup vimrc_defx
        autocmd!
        autocmd FileType defx call s:defx_mappings()                                  "Defx mappings
        autocmd VimEnter * call s:setup_defx()
        autocmd VimEnter * call fugitive#detect(expand('<afile>')) | call lightline#update()
    augroup END

    " Mapping
    nnoremap <silent><Leader>n :call <sid>defx_open({ 'split': v:true })<CR>
    nnoremap <silent><Leader>hf :call <sid>defx_open({ 'split': v:true, 'find_current_file': v:true })<CR>
    let s:default_columns = 'indent:git:icons:filename'

    function! s:setup_defx() abort
        call defx#custom#option('_', {
                \ 'columns': s:default_columns,
                \ })

        call defx#custom#column('filename', {
                \ 'min_width': 80,
                \ 'max_width': 80,
                \ })

        call s:defx_open({ 'dir': expand('<afile>') })
    endfunction

    function s:get_project_root() abort
        let l:git_root = ''
        let l:path = expand('%:p:h')
        let l:cmd = systemlist('cd '.l:path.' && git rev-parse --show-toplevel')
        if !v:shell_error && !empty(l:cmd)
            let l:git_root = fnamemodify(l:cmd[0], ':p:h')
        endif

        if !empty(l:git_root)
            return l:git_root
        endif

        return getcwd()
    endfunction

    function! s:defx_open(...) abort
        let l:opts = get(a:, 1, {})
        let l:path = get(l:opts, 'dir', s:get_project_root())

        if !isdirectory(l:path) || &filetype ==? 'defx'
            return
        endif

        let l:args = '-winwidth=40 -direction=topleft'

        if has_key(l:opts, 'split')
            let l:args .= ' -split=vertical'
        endif

        if has_key(l:opts, 'find_current_file')
            if &filetype ==? 'defx'
            return
            endif
            call execute(printf('Defx %s -search=%s %s', l:args, expand('%:p'), l:path))
        else
            call execute(printf('Defx -toggle %s %s', l:args, l:path))
            call execute('wincmd p')
        endif

        return execute("norm!\<C-w>=")
    endfunction

    function! s:defx_context_menu() abort
        let l:actions = ['new_multiple_files', 'rename', 'copy', 'move', 'paste', 'remove']
        let l:selection = confirm('Action?', "&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete")
        silent exe 'redraw'

        return feedkeys(defx#do_action(l:actions[l:selection - 1]))
    endfunction

    function s:defx_toggle_tree() abort
        if defx#is_directory()
            return defx#do_action('open_or_close_tree')
        endif
        return defx#do_action('drop')
    endfunction

    function! s:defx_mappings() abort
        nnoremap <silent><buffer>m :call <sid>defx_context_menu()<CR>
        nnoremap <silent><buffer><expr> o <sid>defx_toggle_tree()
        nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
        nnoremap <silent><buffer><expr> <CR> <sid>defx_toggle_tree()
        nnoremap <silent><buffer><expr> <2-LeftMouse> <sid>defx_toggle_tree()
        nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : 'C'
        nnoremap <silent><buffer><expr> s defx#do_action('open', 'botright vsplit')
        nnoremap <silent><buffer><expr> R defx#do_action('redraw')
        nnoremap <silent><buffer><expr> U defx#do_action('multi', [['cd', '..'], 'change_vim_cwd'])
        nnoremap <silent><buffer><expr> H defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
        nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer> J :call search('')<CR>
        nnoremap <silent><buffer> K :call search('', 'b')<CR>
        nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> q defx#do_action('quit')
        silent exe 'nnoremap <silent><buffer><expr> tt defx#do_action("toggle_columns", "'.s:default_columns.':size:time")'
    endfunction

" }

" indentLine {
    let g:indentline_enabled = 1
    let g:indentline_char='┆'
    let g:indentLine_fileTypeExclude = ['defx', 'tagbar']
    let g:indentLine_concealcursor = 'niv'
    let g:indentLine_color_term = 96
    let g:indentLine_color_gui= '#725972'
    let g:indentLine_showFirstIndentLevel =1
" }

" Defx-git {
    let g:defx_git#indicators = {
        \ 'Modified'  : '•',
        \ 'Staged'    : '✚',
        \ 'Untracked' : 'ᵁ',
        \ 'Renamed'   : '≫',
        \ 'Unmerged'  : '≠',
        \ 'Ignored'   : 'ⁱ',
        \ 'Deleted'   : '✖',
        \ 'Unknown'   : '⁇'
        \ }
    let g:defx_git#column_length = 1
    let g:defx_git#show_ignored = 0
    let g:defx_git#raw_mode = 0
    " Icons
    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_column_length = 2
    let g:defx_icons_directory_icon = ''
    let g:defx_icons_mark_icon = '*'
    let g:defx_icons_parent_icon = ''
    let g:defx_icons_default_icon = ''
    let g:defx_icons_directory_symlink_icon = ''
    " Options below are applicable only when using "tree" feature
    let g:defx_icons_root_opened_tree_icon = ''
    let g:defx_icons_nested_opened_tree_icon = ''
    let g:defx_icons_nested_closed_tree_icon = ''

" }

" Calendar {
    nmap <silent><leader>rl :Calendar<CR>
    function! Help_calendar() abort
        echo 'View:'
        echo '< left view'
        echo '>: right view'
        echo 'E: Open / close event window'
        echo 'T: open / close the task window'
        echo 'C: Change events / tasks'
        echo 'D: Delete event / finish tasks'
        echo 'L: clear all completed tasks'
        echo 'U: the task identifier is not completed'
        echo 'T: jump to the current date'
        echo ': display help'
        echo 'Q: exit'
    endfunction
" }
