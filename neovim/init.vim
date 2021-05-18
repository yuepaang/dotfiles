" File              : init.vim
" Author            : Yue Peng <yuepaang@gmail.com>
" Date              : 2019-07-12 11:01:48
" Last Modified Date: 2021-05-18 10:13:00
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


let s:plug_dir = expand('~/.config/nvim/plugged')
if !isdirectory(s:plug_dir)
  execute printf('!curl -fLo %s/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', s:plug_dir)
end

call plug#begin(s:plug_dir)
    Plug 'scrooloose/nerdcommenter'
    Plug 'cinuor/vim-header'
    Plug 'heavenshell/vim-pydocstring', {'do': 'make install'}
    Plug 'dense-analysis/ale'
    Plug 'nathunsmitty/nvim-ale-diagnostic'
    Plug 'majutsushi/tagbar'
    Plug 'vim-scripts/IndexedSearch'
    Plug 'haya14busa/incsearch.vim'
    Plug 'junegunn/fzf', {'do': { -> system('./install --all')}}
    Plug 'junegunn/fzf.vim'
    Plug 'fszymanski/fzf-quickfix'
    Plug 'sheerun/vim-polyglot'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'norcalli/snippets.nvim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'

    Plug 'tpope/vim-fugitive'
    Plug 'rhysd/git-messenger.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/gv.vim'
    Plug 'dhruvasagar/vim-open-url'
    Plug 'mg979/vim-visual-multi'
    Plug 'Yggdroot/indentLine'
    Plug 'mhinz/vim-startify'
    Plug 'sainnhe/sonokai'
    Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
    Plug 'kyazdani42/nvim-web-devicons'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'kabouzeid/nvim-lspinstall'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'hrsh7th/nvim-compe'
    Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-media-files.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'folke/lsp-colors.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'sbdchd/neoformat'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-tree.lua'

" Initialize plugin system
call plug#end()
" PlugInstall | quit


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

    nnoremap <silent> <C-g> :Rg<CR>
    nnoremap <silent> tc :Commits<CR>
    nnoremap <silent> tp :BLines<CR>

" }


" neovim {
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
    set colorcolumn=80
    set hidden
    set list lcs=tab:\|\ " tab indent guide
    if &compatible
        set nocompatible
    endif

    " Appearance
    set noruler noshowcmd
    set cursorline
    set scrolloff=6
    set lz
    set updatetime=300
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
    " silent! set cursorline nocursorcolumn colorcolumn=80 concealcursor=nvc conceallevel=0 norelativenumber
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
    silent! set complete& completeopt+=menuone,noselect infercase noshowfulltag shortmess+=c

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
    filetype off
    filetype plugin on
    filetype indent on

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


    " color {
        " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        " Mac Terminal not working
        set termguicolors
        set t_Co=256

        " colorscheme cosmic_latte
        set background=light
        " set background=dark
        let g:github_colors_soft = 1
        let g:github_colors_block_diffmark = 0
        let g:enable_bold_font = 1
        let g:enable_italic_font = 1


        " sets the cursor to a vertical line for insert mode, underline for replace mode, and block for normal mode
        let &t_SI = "\<Esc>[6 q"
        let &t_SR = "\<Esc>[4 q"
        let &t_EI = "\<Esc>[2 q"

        if &diff
            colorscheme github
        else
            " The configuration options should be placed before `colorscheme sonokai`.
            " let g:sonokai_style = 'andromeda'
            let g:sonokai_style = 'shusia'
            let g:sonokai_enable_italic = 1
            let g:sonokai_disable_italic_comment = 1
            colorscheme sonokai

            set fillchars+=vert:│

        endif

        hi Conceal guifg=#666666 ctermfg=255 guibg=#282828 ctermbg=235 gui=NONE cterm=NONE


        " neovim highlight yanked region"
        augroup highlight_yank
            autocmd!
            " autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
            au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
        augroup END

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

" }

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
    let g:pydocstring_formatter = 'google'
" }

" git-messager {
    nmap dm <Plug>(git-messenger)
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
    let g:indentLine_fileTypeExclude = ['coc-explorer']
    let g:indentLine_concealcursor = 'niv'
    let g:indentLine_color_term = 96
    let g:indentLine_color_gui= '#725972'
    let g:indentLine_showFirstIndentLevel =1
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

" Completion
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.vsnips = v:true
let g:compe.source.snippets_nvim = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true

let g:compe.source.tabnine = v:true
let g:compe.source.tabnine = {}
let g:compe.source.tabnine.max_line = 1000
let g:compe.source.tabnine.max_num_results = 6
let g:compe.source.tabnine.priority = 5000
" setting sort to false means compe will leave tabnine to sort the completion items
let g:compe.source.tabnine.sort = v:false
let g:compe.source.tabnine.show_prediction_strength = v:true
let g:compe.source.tabnine.ignore_pattern = ''

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

highlight link CompeDocumentation NormalFloat


nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>

nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent> gd :Lspsaga preview_definition<CR>


nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>



lua << EOF
require('file-icons')
require('misc-utils')
require('top-bufferline')
require('statusline')
require('telescope-nvim')
require('nvimtree')
require('treesitter')

require("nvim-ale-diagnostic")
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

require('nvim-autopairs').setup()

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { noremap=true, silent=true }
   buf_set_keymap('n', 'gdd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

end

local servers = {'vimls', 'pyright', 'gopls', 'rust_analyzer'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
    }
end

EOF

