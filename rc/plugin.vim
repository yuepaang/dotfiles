function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'})

    call minpac#add('scrooloose/nerdtree')
    call minpac#add('Xuyuanp/nerdtree-git-plugin')
    call minpac#add('low-ghost/nerdtree-fugitive')
    call minpac#add('tiagofumo/vim-nerdtree-syntax-highlight')
    call minpac#add('ivalkeen/nerdtree-execute')

    call minpac#add('scrooloose/nerdcommenter')

    call minpac#add('junegunn/fzf', {'do': './install --all'})
    call minpac#add('junegunn/fzf.vim')

    call minpac#add('sheerun/vim-polyglot')

    call minpac#add('iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install()}})

    call minpac#add('Shougo/echodoc.vim')

    call minpac#add('SirVer/ultisnips')
    call minpac#add('honza/vim-snippets')
    call minpac#add('Shougo/neosnippet')
    call minpac#add('Shougo/neosnippet-snippets')


    call minpac#add('tpope/vim-fugitive')
    call minpac#add('tpope/vim-rhubarb')

    call minpac#add('mg979/vim-visual-multi')
    call minpac#add('Yggdroot/indentLine')

    call minpac#add('morhetz/gruvbox')
    call minpac#add('nanotech/jellybeans.vim')

    call minpac#add('itchyny/lightline.vim')

    call minpac#add('machakann/vim-highlightedyank')

endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
