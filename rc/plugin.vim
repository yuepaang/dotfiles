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

    call minpac#add('Shougo/neco-vim')
    call minpac#add('ncm2/ncm2-vim')
    call minpac#add('Shougo/neco-syntax')
    call minpac#add('ncm2/ncm2-syntax')

    call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': { -> system('bash install.sh')}})

    call minpac#add('scrooloose/nerdtree')
    call minpac#add('Xuyuanp/nerdtree-git-plugin')
    call minpac#add('low-ghost/nerdtree-fugitive')
    call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')
    call minpac#add('ivalkeen/nerdtree-execute')

    call minpac#add('scrooloose/nerdcommenter')

    call minpac#add('junegunn/fzf', {'do': { -> system('./install --all')}})
    call minpac#add('junegunn/fzf.vim')

    call minpac#add('sheerun/vim-polyglot')

    call minpac#add('iamcco/markdown-preview.nvim', {'do': { -> system("cd app & yarn install")}})

    call minpac#add('Shougo/echodoc.vim')

    call minpac#add('SirVer/ultisnips')
    call minpac#add('honza/vim-snippets')
    call minpac#add('Shougo/neosnippet')
    call minpac#add('Shougo/neosnippet-snippets')


    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-rhubarb')

    call minpac#add('mg979/vim-visual-multi')
    call minpac#add('Yggdroot/indentLine')

    call minpac#add('nanotech/jellybeans.vim')

    call minpac#add('itchyny/lightline.vim')
    call minpac#add('itchyny/vim-gitbranch')
    call minpac#add('macthecadillac/lightline-gitdiff')

    call minpac#add('machakann/vim-highlightedyank')

endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
