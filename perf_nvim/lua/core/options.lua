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
    termguicolors  = true;
    mouse          = 'nv';
    errorbells     = true;
    visualbell     = true;
    hidden         = true;
    fileformats    = "unix,mac,dos";
    magic          = true;
    virtualedit    = "block";
    encoding       = "utf-8";
    viewoptions    = "folds,cursor,curdir,slash,unix";
    clipboard      = "unnamedplus";
    wildignorecase = true;
    wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
    backup = false;
    writebackup = false;
    directory      = global.cache_dir .. "swag/";
    undodir        = global.cache_dir .. "undo/";
    viewdir        = global.cache_dir .. "view/";
    spellfile      = global.cache_dir .. "spell/en.uft-8.add";
    history        = 2000;
    smarttab       = true;
    timeout        = true;
    ttimeout       = true;
    timeoutlen     = 500;
    ttimeoutlen    = 10;
    updatetime     = 100;
    redrawtime     = 1500;
    ignorecase     = true;
    smartcase      = true;
    infercase      = true;
    incsearch      = true;
    wrapscan       = true;
    inccommand     = "nosplit";
    grepformat     = "%f:%l:%c:%m";
    grepprg        = 'rg --hidden --vimgrep --smart-case --';
    breakat        = [[\ \	;:,!?]];
    startofline    = false;
    whichwrap      = "h,l,<,>,[,],~";
    splitbelow     = true;
    splitright     = true;
    switchbuf      = "useopen";
    backspace      = "indent,eol,start";
    diffopt        = "filler,iwhite,internal,algorithm:patience";
    completeopt    = "menu,menuone,noselect";
    jumpoptions    = "stack";
    showmode       = false;
    shortmess      = "aoOTIcF";
    scrolloff      = 2;
    sidescrolloff  = 5;
    foldlevelstart = 99;
    ruler          = false;
    list           = true;
    --showtabline    = 2;
    winwidth       = 30;
    winminwidth    = 15;
    pumheight      = 15;
    helpheight     = 12;
    previewheight  = 12;
    showcmd        = false;
    cmdheight      = 1;
    cmdwinheight   = 5;
    equalalways    = false;
    laststatus     = 2;
    display        = "lastline";
    showbreak      = "↳";
    listchars      = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
    pumblend       = 0;
    winblend       = 10;
	number         = true;
	relativenumber = true;
  }

  local bw_local  = {
    undofile       = true;
    synmaxcol      = 2500;
    formatoptions  = "1jcroql";
    textwidth      = 80;
    expandtab      = false;
    autoindent     = true;
    tabstop        = 4;
    shiftwidth     = 4;
    softtabstop    = -1;
    breakindentopt = "shift:2,min:20";
    wrap           = true;
    linebreak      = true;
    colorcolumn    = "80";
    foldenable     = true;
    signcolumn     = "yes";
    conceallevel   = 0;
    concealcursor  = "niv";
  }

  vim.g.clipboard = {
    name = "myProvider",
    copy = {
      ["+"] = "clipboard-provider copy",
      ["*"] = "clipboard-provider copy",
    },
    paste = {
      ["+"] = "clipboard-provider paste",
      ["*"] = "clipboard-provider paste",
    },
    cache_enabled = 0
  }

  if global.is_mac then
    vim.g.python_host_skip_check=1
    vim.g.python_host_prog = '/usr/bin/python'
    vim.g.python3_host_skip_check=1
    vim.g.python3_host_prog = '/usr/local/opt/python@3.10/bin/python3'
  end

  if global.is_linux then
    vim.g.python_host_skip_check=1
    vim.g.python_host_prog = '/usr/bin/python'
    vim.g.python3_host_skip_check=1
    vim.g.python3_host_prog = '/usr/bin/python3'
  end

  for name, value in pairs(global_local) do
    vim.o[name] = value
  end
  bind_option(bw_local)
end

load_options()

