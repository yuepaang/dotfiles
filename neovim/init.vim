" File              : init.vim
" Author            : Yue Peng <yuepaang@gmail.com>
" Date              : 2021-05-16 14:41:41
" Last Modified Date: 2021-05-16 14:41:41
" Last Modified By  : Yue Peng <yuepaang@gmail.com>

let g:ascii = [
\ '|                                                     |',
\ '|       ####     ######    #     #      ######        |',
\ '|      #    #    #         ##    #     #              |',
\ '|      #    #    #         # #   #    #               |',
\ '|      #  #      ######    #  #  #    #    #####      |',
\ '|      #         #         #   # #     #       #      |',
\ '|      #         #         #    ##      #     #       |',
\ '|      #         ######    #     #       #####        |',
\]

call plug#begin('~/.config/nvim/plugged')

    " Collection of common configurations for the Nvim LSP client
    Plug 'neovim/nvim-lspconfig'

    " Extensions to built-in LSP, for example, providing type inlay hints
    Plug 'nvim-lua/lsp_extensions.nvim'

    " Autocompletion framework for built-in LSP
    Plug 'nvim-lua/completion-nvim'

    Plug 'rust-lang/rust.vim'

    " Utilities {
        Plug 'scrooloose/nerdcommenter'
        Plug 'cinuor/vim-header'
        Plug 'heavenshell/vim-pydocstring'
        Plug 'itchyny/calendar.vim'
    " }

    " tags view {
        Plug 'majutsushi/tagbar'
    " }

    " tags view {
        Plug 'kyazdani42/nvim-web-devicons' " for file icons
    " }

    " Search {
        Plug 'vim-scripts/IndexedSearch'
        Plug 'haya14busa/incsearch.vim'
    " }

    " fzf {
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'fszymanski/fzf-quickfix'
    " }

    " Better language pack {
        Plug 'sheerun/vim-polyglot'
    " }

    " Snippets {
        Plug 'honza/vim-snippets'
        Plug 'SirVer/ultisnips'
    " }

    " Git {
        Plug 'tpope/vim-fugitive'
        " call minpac#add('tpope/vim-rhubarb')
        Plug 'rhysd/git-messenger.vim'
        Plug 'airblade/vim-gitgutter'
        Plug 'junegunn/gv.vim'
    " }

    " Coding {
        Plug 'mg979/vim-visual-multi'
        Plug 'Yggdroot/indentLine'
        Plug 'easymotion/vim-easymotion'
    " }
        Plug 'sainnhe/sonokai'
        Plug 'mhinz/vim-startify'
        Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
        Plug 'jlanzarotta/bufexplorer'
        Plug 'mg979/vim-xtabline'
        Plug 'voldikss/vim-floaterm'

" Initialize plugin system
call plug#end()

" Improve Performance
let g:python_host_skip_check=1
let g:python3_host_skip_check=1

" Define interpreter path
if has('mac')
    let g:python3_host_prog='/usr/local/bin/python3'
    let g:python_host_prog='/usr/local/bin/python'
else
    let g:python3_host_prog='/usr/bin/python3'
    let g:python_host_prog='/usr/bin/python'
endif


" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

let g:completion_enable_snippet = 'UltiSnips'

" fugitive {
	nmap tf :Gdiff<CR>
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

    nnoremap <silent> <C-g> :Rg<CR>
    nnoremap <silent> tc :Commits<CR>
    nnoremap <silent> tp :BLines<CR>

" }

function! ConfigStatusLine()
  lua require('plugins.status-line')
endfunction

augroup status_line_init
  autocmd!
  autocmd VimEnter * call ConfigStatusLine()
augroup END

" nerdcommenter {
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

    " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1

" }

" Tagbar {

    nmap <silent> <F4> :TagbarToggle<CR>

    let g:tagbar_width=35
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
    let g:pydocstring_formatter = 'numpy'
" }

" git-messager {
    nmap cm <Plug>(git-messenger)
" }

" vim-header {
    let g:header_auto_add_header = 0
    let g:header_field_timestamp_format = '%Y-%m-%d %H:%M:%S'
    let g:header_field_author = 'Yue Peng'
    let g:header_field_author_email = 'yuepaang@gmail.com'
    map <F7> :AddHeader<CR>
" }

" indentLine {
    let g:indentline_enabled = 1
    let g:indentline_char='┆'
    " for indentLine
    let g:indentLine_fileTypeExclude = ['tagbar']
    let g:indentLine_concealcursor = 'niv'
    let g:indentLine_color_term = 96
    let g:indentLine_color_gui= '#725972'
    let g:indentLine_showFirstIndentLevel =1
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

" floaterm {
	hi FloatermNF guibg=#333333
	let g:floaterm_position		 = 'center'
    let g:floaterm_keymap_new    = '<Leader>fn'
	let g:floaterm_keymap_prev	 = '<leader>fp'
	let g:floaterm_keymap_next	 = '<leader>fn'
	let g:floaterm_keymap_toggle = '<leader>ff'


    let g:floaterm_autoclose=1
    let g:floaterm_width=0.8
    let g:floaterm_height=0.8
" }

" startify {
    map <leader>o :Startify<cr>

    let g:startify_custom_header = g:ascii " + startify#fortune#boxed()

    let g:startify_files_number = 15
    let g:startify_lists = [
    \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
    \ { 'type': 'files',     'header': ['   Files']                        },
    \ ]

    let g:startify_bookmarks = [
    \ { 'v': '~/dotfiles/neovim/init.vim' },
    \ { 'z': '~/.zshrc' },
    \ ]

    let g:startify_enable_special = 0

    let g:startify_custom_footer =
    \ ['', "   PangHuXiong", '']

" }

" Buffer explorer {
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
nmap <leader>n :BufExplorer<CR>
" }


" vim-xtabline {

let g:xtabline_settings = get(g:, 'xtabline_settings', {})
let g:xtabline_settings.map_prefix = '<leader>x'
let g:xtabline_settings.tabline_modes = ['buffers', 'tabs']
autocmd vimenter * XTabTheme slate
autocmd bufenter * XTabTheme slate
let g:xtabline_settings.buffers_paths = 0
let g:xtabline_settings.current_tab_paths = 0
let g:xtabline_settings.other_tabs_paths = 0
map <leader>xq :XTabCloseBuffer<cr>
map <leader>xl :XTabListBuffers<cr>
" }

let g:mapleader="\<SPACE>"
let g:maplocalleader=","

let &ls = 2
let pumwidth = 40
let pumheight = 20

augroup CustomGroup
    autocmd!
    au InsertEnter * set norelativenumber
    au InsertLeave * set relativenumber
    au BufEnter * set formatoptions-=cross
augroup END

" select only to the last character of the line
set selection=exclusive
set fdm=marker

" Clear current-search highlighting by hitting <CR> in normal mode.
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" To disable conceal regardless of conceallevel setting
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1

set autowrite
set autochdir!
set hidden
set list lcs=tab:\|\ " tab indent guide
set nocompatible

" Appearance
set noruler noshowcmd
set scrolloff=6
set lz
set noshowmode
set laststatus=2
set cmdheight=2
set shortmess+=I
set title
set titlestring=%-25.55F\ %a%r%m titlelen=70"
set mouse=a
set go-=T


silent! set number relativenumber display=lastline,uhex wrap wrapmargin=0 guioptions=ce key=
" silent! set noshowmatch matchtime=1 noshowmode shortmess+=I cmdheight=2 cmdwinheight=10 showbreak=
" silent! set noshowcmd noruler rulerformat= laststatus=2 statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
" silent! set title titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=1
silent! set cursorline nocursorcolumn colorcolumn=80 concealcursor=nvc conceallevel=0
" silent! set list listchars=tab:>\ ,nbsp:_ synmaxcol=3000 ambiwidth=double breakindent breakindentopt=
silent! set startofline linespace=0 whichwrap=b,s sidescroll=0
" silent! set equalalways nowinfixwidth nowinfixheight winminwidth=3 winminheight=3 nowarn noconfirm
silent! set fillchars=vert:\|,fold:\  eventignore= helplang=en viewoptions=options,cursor virtualedit=block

" Editing
silent! set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
silent! set smartindent autoindent shiftround shiftwidth=4 expandtab tabstop=4 smarttab softtabstop=4
silent! set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
silent! set textwidth=0 backspace=indent,eol,start nrformats-=octal formatoptions-=cro nojoinspaces
silent! set noautochdir write nowriteany writedelay=0 verbose=0 verbosefile= notildeop noinsertmode
silent! set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags
silent! set tags+=../../../../../../tags,../../../../../../../tags,~/Documents/scala/tags,~/Documents/*/tags tagstack

" Clipboard
silent! set clipboard=unnamed,unnamedplus

" Search
silent! set wrapscan ignorecase smartcase incsearch hlsearch magic

" Insert completion
silent! set complete& completeopt+=menu,menuone,noinsert,noselect infercase noshowfulltag shortmess+=c

" Command line
silent! set wildchar=9 wildmenu wildmode=list:longest,full wildoptions= wildignorecase cedit=<C-k>
silent! set wildignore=*.~,*.?~,*.o,*.sw?,*.bak,*.hi,*.pyc,*.out,*.lock suffixes=*.pdf

" Performance
silent! set updatetime=300 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw
set tm=1000 ttm=50
silent! set backup swapfile undofile
" Option
silent! set signcolumn=yes splitbelow splitright

syntax enable
syntax on
filetype plugin indent on

set spelllang=en_us

set encoding=utf-8 nobomb
set termencoding=utf-8
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set fileformats=unix,dos,mac
scriptencoding utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936


if &ls == 2 | set nosmd | endif
if exists('&pumwidth') | let &pumwidth = pumwidth | endif
if exists('&pumheight') | let &pumheight = pumheight | endif

let vimrcdir   = fnamemodify(expand("$MYVIMRC"), ":h")
let &directory = vimrcdir."/.vim/swap//"
let &backupdir = vimrcdir."/.vim/backup//"
let &undodir = vimrcdir."/.vim/undo//"

for directory in [&directory, &backupdir, &undodir]
if !isdirectory(directory)
    call mkdir(directory, 'p')
endif
endfor

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

" Add datetime
:nnoremap <F2> "=strftime("%Y-%m-%d %H:%M:%S")<CR>P
:inoremap <F2> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

" quit
map <C-q> :q<cr>
map <leader>q :q<cr>

noremap <C-t> :tabnew split<CR>

" save
map <leader>w :w<CR>
cmap w!! w !sudo tee >/dev/null %
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> :w<CR>

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
