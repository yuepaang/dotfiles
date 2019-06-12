let g:mapleader="\<SPACE>"
let g:maplocalleader=","

syntax enable
filetype off
filetype plugin on
filetype indent on

set modeline
set ttyfast
set magic

set encoding=utf-8

set mouse=a
set mousehide

set number
set relativenumber

set hidden
set nocursorline

set autoindent
set smartindent

set nobackup
set noswapfile
set nowritebackup

set hlsearch
set incsearch
set ignorecase
set infercase
set smartcase

set tabstop=4
set signcolumn=yes
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab
set colorcolumn=80

set cmdheight=2
set noshowmode
set noshowcmd

set foldenable
set foldmethod=syntax
set foldcolumn=0
setlocal foldlevel=1
set foldlevelstart=99

set splitbelow
set splitright

set clipboard+=unnamedplus
au FileType json setlocal equalprg=python\ -m\ json.tool

set wrap
set fileformat=unix

hi Directory guifg=#FF0000

set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest

set lazyredraw

set completeopt+=menu,menuone,noinsert,noselect
set shortmess+=c
set completeopt-=preview

if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    " Disable tabline.
    set showtabline=0

    " Set statusline.
    set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
endif


set t_Co=256
set termguicolors

set background=dark
colorscheme jellybeans

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

" netrw {{{
let g:netrw_liststyle=3
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_sort_sequence = '[\/]$,*'

" do not display info on the top of window
let g:netrw_banner = 0
" }}}

nmap <leader><tab> :FZF<CR>
