local global = require("core.global")

local function bind_option(options)
    for k, v in pairs(options) do
        if v == true then
            vim.cmd('set ' .. k)
        elseif v == false then
            vim.cmd('set ' .. 'no' .. k)
        else
            vim.cmd('set ' .. k .. '=' .. v)
        end
    end
end

local function load_options()
    local global_local = {
        termguicolors = true,
        mouse = 'a',
        errorbells = true,
        visualbell = true,
        hidden = true,
        fileformats = "unix,mac,dos",
        magic = true,
        virtualedit = "block",
        encoding = "utf-8",
        viewoptions = "folds,cursor,curdir,slash,unix",
        clipboard = "unnamedplus",
        wildignorecase = true,
        wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
        backup = false,
        writebackup = false,
        directory = global.cache_dir .. "swag/",
        undodir = global.cache_dir .. "undo/",
        viewdir = global.cache_dir .. "view/",
        spellfile = global.cache_dir .. "spell/en.uft-8.add",
        history = 2000,
        smarttab = true,
        timeout = true,
        ttimeout = true,
        timeoutlen = 500,
        ttimeoutlen = 10,
        updatetime = 100,
        redrawtime = 1500,
        ignorecase = true,
        smartcase = true,
        infercase = true,
        hlsearch = true,
        incsearch = true,
        wrapscan = true,
        inccommand = "nosplit",
        grepformat = "%f:%l:%c:%m",
        grepprg = 'rg --hidden --vimgrep --smart-case --',
        breakat = [[\ \	;:,!?]],
        startofline = false,
        whichwrap = "h,l,<,>,[,],~",
        splitbelow = true,
        splitright = true,
        switchbuf = "useopen",
        backspace = "indent,eol,start",
        diffopt = "filler,iwhite,internal,algorithm:patience",
        completeopt = "menu,menuone,noselect",
        jumpoptions = "stack",
        showmode = false,
        shortmess = "aoOTIcF",
        scrolloff = 2,
        sidescrolloff = 5,
        foldlevelstart = 99,
        ruler = false,
        list = true,
        showmatch = true,
        background = 'dark',
        -- showtabline    = 2;
        winwidth = 30,
        winminwidth = 15,
        pumheight = 15,
        helpheight = 12,
        previewheight = 12,
        showcmd = false,
        cmdheight = 1,
        cmdwinheight = 5,
        equalalways = false,
        laststatus = 2,
        display = "lastline",
        showbreak = "↳",
        listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
        pumblend = 10,
        winblend = 10,
        number = true,
        relativenumber = true,
        cursorline = true
    }

    local bw_local = {
        undofile = true,
        synmaxcol = 2500,
        formatoptions = "1jcroql",
        textwidth = 80,
        expandtab = false,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,
        breakindentopt = "shift:2,min:20",
        wrap = true,
        linebreak = true,
        colorcolumn = "80",
        foldenable = true,
        signcolumn = "yes",
        conceallevel = 0,
        concealcursor = "niv"
    }

    vim.g.clipboard = {
        name = "myProvider",
        copy = {
            ["+"] = "clipboard-provider copy",
            ["*"] = "clipboard-provider copy"
        },
        paste = {
            ["+"] = "clipboard-provider paste",
            ["*"] = "clipboard-provider paste"
        },
        cache_enabled = 0
    }

    vim.g.python3_host_skip_check = 1
    vim.g.python3_host_prog = '$HOME/.pyenv/versions/3.10.2/bin/python'

    for name, value in pairs(global_local) do
        vim.o[name] = value
    end
    bind_option(bw_local)

    -- disable builtins plugins
    local disabled_built_ins = {"netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip",
                                "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball",
                                "vimballPlugin", "2html_plugin", "logipat", "rrhelper", "spellfile_plugin", "matchit"}

    for _, plugin in pairs(disabled_built_ins) do
        vim.g["loaded_" .. plugin] = 1
    end

    vim.cmd [[
		hi Pmenu ctermfg=white ctermbg=238
	]]

    vim.cmd [[
		" Uncomment the following to have Vim jump to the last position when
		" reopening a file
		if has("autocmd")
			au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
		endif
	]]
    vim.cmd [[
		autocmd WinEnter * setlocal cursorline
		autocmd WinLeave * setlocal nocursorline
	]]
end

load_options()
