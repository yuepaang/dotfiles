-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["barbar.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\3\0\6\0\t6\0\0\0009\0\1\0005\1\3\0004\2\0\0=\2\4\0014\2\0\0=\2\5\1=\1\2\0K\0\1\0\17exclude_name\15exclude_ft\1\0\17\fletters:asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP\21semantic_letters\2\19maximum_length\3\30\20maximum_padding\3\1\18insert_at_end\1\16icon_pinned\b車\28icon_close_tab_modified\b●\19icon_close_tab\b\28icon_separator_inactive\b▎\26icon_separator_active\b▎\23icon_custom_colors\1\nicons\2\14clickable\2\rclosable\2\rtabpages\2\14auto_hide\2\14animation\2\15bufferline\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/barbar.nvim"
  },
  ["caw.vim"] = {
    config = { "\27LJ\2\n�\1\0\0\6\0\a\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\6x\23<Plug>(caw:prefix)\14<Leader>c\6n\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "", "n" }, { "", "<Leader>c" } },
    loaded = false,
    needs_bufread = true,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/caw.vim"
  },
  ["coc.nvim"] = {
    after = { "vim-snippets" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/coc.nvim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.ui.eviline\frequire\0" },
    loaded = true,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\2\0\a\0\0176\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0K\0\1\0\26mkdp_echo_preview_url\f0.0.0.0\17mkdp_open_ip\27mkdp_open_to_the_world\20mkdp_auto_start\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["nvim-cheat.sh"] = {
    after = { "popfix" },
    commands = { "Cheat", "CheatList", "CheatWithoutComments", "CheatListWithoutComments" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-cheat.sh"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-virtual-text", "nvim-dap-ui" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins.debug.dapconfig\frequire\0" },
    keys = { { "n", "<F5>" }, { "n", "<F9>" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\ndapui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\21dap_virtual_text\6g\bvim\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeOpen" },
    config = { "\27LJ\2\n�\3\0\0\6\0\16\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0004\4\0\0=\4\6\3=\3\a\0025\3\b\0004\4\0\0=\4\t\3=\3\n\0025\3\v\0005\4\f\0004\5\0\0=\5\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\3\tside\tleft\nwidth\3\31\16auto_resize\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\15update_cwd\1\venable\1\23ignore_ft_on_setup\1\0\b\20lsp_diagnostics\2\15update_cwd\2\18hijack_cursor\2\16open_on_tab\1\15auto_close\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-rainbow" },
    config = { "\27LJ\2\n�\2\0\0\5\0\n\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0004\4\0\0=\4\a\0034\4\0\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\frainbow\15termcolors\vcolors\1\0\3\18extended_mode\2\venable\2\19max_file_lines\3�\a\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  popfix = {
    load_after = {
      ["nvim-cheat.sh"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/popfix"
  },
  ["popup.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/popup.nvim"
  },
  ["telescope-coc.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope-coc.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n�\5\0\0\a\0\29\0@6\0\0\0009\0\1\0009\0\2\0\14\0\0\0X\0\16�6\0\3\0009\0\4\0'\2\5\0B\0\2\0016\0\3\0009\0\4\0'\2\6\0B\0\2\0016\0\3\0009\0\4\0'\2\a\0B\0\2\0016\0\3\0009\0\4\0'\2\b\0B\0\2\0016\0\t\0'\2\n\0B\0\2\0029\0\v\0005\2\21\0005\3\f\0006\4\t\0'\6\r\0B\4\2\0029\4\14\0049\4\15\4=\4\16\0036\4\t\0'\6\r\0B\4\2\0029\4\17\0049\4\15\4=\4\18\0036\4\t\0'\6\r\0B\4\2\0029\4\19\0049\4\15\4=\4\20\3=\3\22\0025\3\24\0005\4\23\0=\4\25\3=\3\26\2B\0\2\0016\0\t\0'\2\n\0B\0\2\0029\0\27\0'\2\25\0B\0\2\0016\0\t\0'\2\n\0B\0\2\0029\0\27\0'\2\28\0B\0\2\1K\0\1\0\bcoc\19load_extension\15extensions\15fzy_native\1\0\0\1\0\2\28override_generic_sorter\1\25override_file_sorter\2\rdefaults\1\0\0\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\25telescope.previewers\1\0\3\20selection_caret\t \21sorting_strategy\14ascending\18prompt_prefix\n🔭 \nsetup\14telescope\frequire\31packadd telescope-coc.nvim&packadd telescope-fzy-native.nvim\23packadd popup.nvim\25packadd plenary.nvim\bcmd\bvim\vloaded\17plenary.nvim\19packer_plugins\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["venn.nvim"] = {
    commands = { "VBox", "VFill" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/venn.nvim"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n�\1\0\0\6\0\b\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\4\0'\4\a\0004\5\0\0B\0\5\1K\0\1\0\26<Plug>(EasyAlign)<CR>\6n\22<Plug>(EasyAlign)\ama\6x\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "n", "ma" }, { "x", "ma" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-easymotion"] = {
    config = { "\27LJ\2\nm\0\0\6\0\6\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\"<Plug>(easymotion-overwin-f2)\14<Leader>s\6n\20nvim_set_keymap\bapi\bvim\0" },
    keys = { { "", "n" }, { "", "<Leader>s" } },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-easymotion"
  },
  ["vim-floaterm"] = {
    commands = { "FloatermToggle", "FloatermNew" },
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-snippets"] = {
    load_after = {
      ["coc.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-snippets"
  },
  ["vim-sonictemplate"] = {
    commands = { "Template" },
    config = { "\27LJ\2\n�\1\0\0\4\0\t\0\0146\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0006\1\5\0009\1\6\1'\3\a\0B\1\2\2'\2\b\0&\1\2\1=\1\4\0K\0\1\0\27/.config/nvim/template\tHOME\vgetenv\aos#sonictemplate_vim_template_dir\n<C-,>\30sonictemplate_postfix_key\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-startuptime"
  },
  ["vim-translator"] = {
    commands = { "TranslateW" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-translator"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    config = { "\27LJ\2\n�\3\0\0\2\0\14\0!6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0005\1\r\0=\1\f\0K\0\1\0\1\0\5\rmarkdown\btoc\vpandoc\rmarkdown\fvimwiki\rmarkdown\20typescriptreact\bcoc\15typescript\bcoc\24vista_executive_for\rmarkdown\28vista_vimwiki_executive\17floating_win\31vista_echo_cursor_strategy\bcoc\28vista_default_executive\29vista_disable_statusline\23vista_stay_on_open\24vista_close_on_jump\31vista#renderer#enable_icon\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vista.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins.ui.eviline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FloatermToggle lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file FloatermNew lua require("packer.load")({'vim-floaterm'}, { cmd = "FloatermNew", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Template lua require("packer.load")({'vim-sonictemplate'}, { cmd = "Template", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeToggle lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NvimTreeOpen lua require("packer.load")({'nvim-tree.lua'}, { cmd = "NvimTreeOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VFill lua require("packer.load")({'venn.nvim'}, { cmd = "VFill", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Cheat lua require("packer.load")({'nvim-cheat.sh'}, { cmd = "Cheat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CheatList lua require("packer.load")({'nvim-cheat.sh'}, { cmd = "CheatList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CheatWithoutComments lua require("packer.load")({'nvim-cheat.sh'}, { cmd = "CheatWithoutComments", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file CheatListWithoutComments lua require("packer.load")({'nvim-cheat.sh'}, { cmd = "CheatListWithoutComments", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VBox lua require("packer.load")({'venn.nvim'}, { cmd = "VBox", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TranslateW lua require("packer.load")({'vim-translator'}, { cmd = "TranslateW", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Vista lua require("packer.load")({'vista.vim'}, { cmd = "Vista", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[xnoremap <silent> ma <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "ma", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> ma <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "ma", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <F5> <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>F5>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Leader>c <cmd>lua require("packer.load")({'caw.vim'}, { keys = "<lt>Leader>c", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <F9> <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>F9>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'caw.vim'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> n <cmd>lua require("packer.load")({'vim-easymotion'}, { keys = "n", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Leader>s <cmd>lua require("packer.load")({'vim-easymotion'}, { keys = "<lt>Leader>s", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'vim-sonictemplate'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'vim-sonictemplate'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'vim-sonictemplate'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim', 'nvim-colorizer.lua', 'vim-sonictemplate'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufNew * ++once lua require("packer.load")({'barbar.nvim'}, { event = "BufNew *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'coc.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate/ftdetect/stpl.vim]], true)
vim.cmd [[source /Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate/ftdetect/stpl.vim]]
time([[Sourcing ftdetect script at: /Users/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-sonictemplate/ftdetect/stpl.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
