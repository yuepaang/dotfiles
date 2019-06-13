let g:mapleader="\<SPACE>"
let g:maplocalleader=","

" Appearance
silent! set number background=dark display=lastline,uhex wrap wrapmargin=0 guioptions=ce key=
silent! set noshowmatch matchtime=1 noshowmode shortmess+=I cmdheight=2 cmdwinheight=10 showbreak=
silent! set noshowcmd noruler rulerformat= laststatus=2 statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
silent! set title titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=1
silent! set cursorline nocursorcolumn colorcolumn=80 concealcursor=nvc conceallevel=0 norelativenumber
silent! set list listchars=tab:>\ ,nbsp:_ synmaxcol=3000 ambiwidth=double breakindent breakindentopt=
silent! set nosplitbelow nosplitright startofline linespace=0 whichwrap=b,s scrolloff=0 sidescroll=0
silent! set equalalways nowinfixwidth nowinfixheight winminwidth=3 winminheight=3 nowarn noconfirm
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
silent! set clipboard=unnamed
silent! set clipboard+=unnamedplus

" Search
silent! set wrapscan ignorecase smartcase incsearch hlsearch magic

" Insert completion
silent! set complete& completeopt+=menu,menuone,noinsert,noselect infercase pumheight=10 noshowfulltag shortmess+=c

" Command line
silent! set wildchar=9 nowildmenu wildmode=list:longest wildoptions= wildignorecase cedit=<C-k>
silent! set wildignore=*.~,*.?~,*.o,*.sw?,*.bak,*.hi,*.pyc,*.out,*.lock suffixes=*.pdf

" Performance
silent! set updatetime=300 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw
silent! set nobackup noswapfile nowritebackup

" Option
silent! set signcolumn=yes splitbelow splitright

syntax enable
filetype off
filetype plugin on
filetype indent on

set encoding=utf-8

set hidden
set nocursorline


" if has('statusline')
"     set laststatus=2
"     " Broken down into easily includeable segments
"     " Disable tabline.
"     set showtabline=0

"     " Set statusline.
"     set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
" endif


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

nmap <leader><tab> :FZF<CR>
