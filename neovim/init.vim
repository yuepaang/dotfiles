" File              : neovim/init.vim
" Author            : Yue Peng <yuepaang@gmail.com>
" Date              : 2019-07-12 11:01:48
" Last Modified Date: 2021-05-15 17:48:51
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
            call coc#util#install_extension(g:coc_global_extensions)
        endfunction

        " call minpac#add('https://github.com/neoclide/coc.nvim', {'branch': 'master', 'do': function('s:coc_plugins')})
        call minpac#add('neoclide/coc.nvim', {'branch': 'master', 'do': {-> system('yarn install --frozen-lockfile')}})
        call minpac#add('https://github.com/Shougo/neco-vim')
        call minpac#add('https://github.com/neoclide/coc-neco')
        call minpac#add('Shougo/neoinclude.vim')
        call minpac#add('jsfaint/coc-neoinclude')
    " }

    " Linter {
        " call minpac#add('w0rp/ale')
    " }

    " Utilities {
        call minpac#add('scrooloose/nerdcommenter')
        call minpac#add('cinuor/vim-header')
        call minpac#add('heavenshell/vim-pydocstring', {'do': 'make install'})
        call minpac#add('itchyny/calendar.vim')
')
    " }

    " tags view {
        call minpac#add('majutsushi/tagbar')
    " }

    " tags view {
        " call minpac#add('scrooloose/nerdtree')
    " }

    " Search {
        call minpac#add('vim-scripts/IndexedSearch')
        call minpac#add('haya14busa/incsearch.vim')  " Better search highlighting
    " }

    " fzf {
        call minpac#add('junegunn/fzf', {'do': { -> system('./install --all')}})
        call minpac#add('junegunn/fzf.vim')
        call minpac#add('fszymanski/fzf-quickfix')
        call minpac#add('antoinemadec/coc-fzf')
    " }

    " Better language pack {
        call minpac#add('sheerun/vim-polyglot')
    " }

    " Snippets {
        call minpac#add('honza/vim-snippets')
        call minpac#add('SirVer/ultisnips')
    " }

    " Git {
        call minpac#add('tpope/vim-fugitive')
        " call minpac#add('tpope/vim-rhubarb')
        call minpac#add('rhysd/git-messenger.vim')
        call minpac#add('airblade/vim-gitgutter')
        call minpac#add('junegunn/gv.vim')

        call minpac#add('dhruvasagar/vim-open-url')
    " }

    " Coding {
        call minpac#add('mg979/vim-visual-multi')
        call minpac#add('Yggdroot/indentLine')

    " }

    " UI {
        call minpac#add('mhinz/vim-startify')
        call minpac#add('junegunn/seoul256.vim')
        call minpac#add('cormacrelf/vim-colors-github')
        " call minpac#add('habamax/vim-polar')
        " call minpac#add('morhetz/gruvbox')
        " call minpac#add('ayu-theme/ayu-vim')
        " call minpac#add('hzchirs/vim-material')
        " call minpac#add('nightsense/cosmic_latte')
        " call minpac#add('jacoborus/tender.vim')
        " call minpac#add('chriskempson/base16-vim')
        " call minpac#add('mhinz/vim-janah')
        " call minpac#add('kristijanhusak/vim-hybrid-material')
        " call minpac#add('jsit/toast.vim')
        " call minpac#add('joshdick/onedark.vim')
        " call minpac#add('adrian5/oceanic-next-vim')
        " call minpac#add('NLKNguyen/papercolor-theme')
        call minpac#add('sainnhe/sonokai')
    " }

    " Status Line {
        call minpac#add('glepnir/galaxyline.nvim', {'branch': 'main'})
        call minpac#add('kyazdani42/nvim-web-devicons')
    " }
    " Terminal {
        call minpac#add('jlanzarotta/bufexplorer')
        call minpac#add('mg979/vim-xtabline')
        call minpac#add('voldikss/vim-floaterm')
    " }

endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

" fix error message
packadd! sonokai

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

function! ConfigStatusLine()
  lua require('cfg.galaxyline')
endfunction

augroup status_line_init
  autocmd!
  autocmd VimEnter * call ConfigStatusLine()
augroup END

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
    set nocompatible

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
    let g:pydocstring_formatter = 'numpy'
" }

" " vim-easy-aligh {
"     " Start interactive EasyAlign in visual mode (e.g. vipga)
"     xmap ga <Plug>(EasyAlign)
"
"     " Start interactive EasyAlign for a motion/text object (e.g. gaip)
"     nmap ga <Plug>(EasyAlign)
" " }

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

" coc.nvim {
    let g:markdown_fenced_languages = [
        \ 'vim',
        \ 'help'
        \]
    let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-html',
        \ 'coc-snippets',
        \ 'coc-ultisnips',
        \ 'coc-pairs',
        \ 'coc-json',
        \ 'coc-git',
        \ 'coc-lists',
        \ 'coc-post',
        \ 'coc-stylelint',
        \ 'coc-yaml',
        \ 'coc-vimlsp',
        \ 'coc-syntax',
        \ 'coc-tag',
        \ 'coc-rust-analyzer',
        \ 'coc-clangd',
        \ 'coc-tabnine',
        \ 'coc-explorer',
        \ 'coc-go',
        \ 'coc-sh',
        \ 'coc-pyright',
        \ 'coc-highlight',
        \ 'coc-imselect',
        \ 'coc-floaterm'
        \ ]
    function! CocBuildUpdate()
        call coc#util#install()
        " call coc#util#install_extension(g:coc_global_extensions)
    endfunction

    command! ExtensionUpdate call CocBuildUpdate()

    " mac iterm2 enhance 'coc-imselect'
    nmap <space>e :CocCommand explorer<CR>


    " coc-go
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

    " Snippets
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
    let g:coc_status_error_sign = '•'
    let g:coc_status_warning_sign = '•'

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " use <c-space>for trigger completion
    inoremap <silent><expr> <c-space> coc#refresh()


    " To make <cr> select the first completion item and confirm completion when no item have selected:
    " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Close preview window when completion is done.
    autocmd! InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " autocmd! BufWritePre *.js,*.json,*.ts Prettier
    " Define some functions that not in coc.nvim
    nnoremap <Plug>(coc-hover) :<C-u>call CocAction("doHover")<CR>
    nmap <silent> gh <Plug>(coc-hover)

    " Remap keys for diagnostic
    nmap <silent> ]w <Plug>(coc-diagnostic-next)
    nmap <silent> [w <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
    nmap <silent> [e <Plug>(coc-diagnostic-prev-error)

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
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
        else
            execute '!' . &keywordprg . " " . expand('<cword>')
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
    vmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` for fold current buffer
    command! -nargs=? Fold :call CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Using CocList
    " Show all diagnostics
    " nnoremap <silent> <leader>la  :<C-u>CocList diagnostics<cr>
    nnoremap <silent> <leader>la  :<C-u>CocFzfList diagnostics<CR>
    nnoremap <silent> <leader>lb  :<C-u>CocFzfList diagnostics --current-buf<CR>
    " Manage extensions
    " nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
    nnoremap <silent> <leader>le  :<C-u>CocFzfList extensions<cr>
    " Show commands
    " nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
    nnoremap <silent> <leader>lc  :<C-u>CocFzfList commands<cr>
    " Find symbol of current document
    " nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
    nnoremap <silent> <leader>lo  :<C-u>CocFzfList outline<cr>
    " Search workspace symbols
    " nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
    nnoremap <silent> <leader>ls  :<C-u>CocFzfList symbols<cr>

    nnoremap <silent> <leader>ll  :<C-u>CocFzfList location<cr>
    nnoremap <silent> <leader>lv  :<C-u>CocFzfList services<cr>
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


    " function! CocHighlight() abort
    "     if &filetype !=# 'markdown'
    "         call CocActionAsync('highlight')
    "     endif
    " endfunction
    "
    "
    " function! CocFloatingLockToggle() abort
    "     if g:CocFloatingLock == 0
    "         let g:CocFloatingLock = 1
    "     elseif g:CocFloatingLock == 1
    "         let g:CocFloatingLock = 0
    "     endif
    " endfunction
    "
    " function! CocHover() abort
    "     if !coc#util#has_float() && g:CocHoverEnable == 1
    "         call CocActionAsync('doHover')
    "         call CocActionAsync('showSignatureHelp')
    "     endif
    " endfunction
    "
    " augroup CocAu
    "     autocmd!
    "     autocmd CursorHold * silent call CocHover()
    "     autocmd CursorHold * silent call CocHighlight()
    "     autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    "     autocmd InsertEnter * call coc#util#float_hide()
    "     autocmd VimEnter * inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
    " augroup END
    " let g:CocHoverEnable = 0

    highlight CocHighlightText cterm=bold gui=bold
    highlight CocErrorHighlight ctermfg=Gray guifg=#888888
    highlight CocCodeLens ctermfg=Gray guifg=#888888

    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

    autocmd FileType markdown let b:coc_pairs_disabled = ['`']
" }


" indentLine {
    let g:indentline_enabled = 1
    let g:indentline_char='┆'
    " for indentLine
    let g:indentLine_fileTypeExclude = ['coc-explorer']
    " let g:indentLine_fileTypeExclude = ['defx', 'tagbar']
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

" easymotion {
" let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
" map <Leader> <Plug>(easymotion-prefix)
" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)
" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" " }
