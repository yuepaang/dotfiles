vim.cmd [[packadd packer.nvim]]
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
local package_path_str = "/home/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/yuepeng/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
  ["Comment.nvim"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    config = { "\27LJ\2\2M\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\2\vsticky\2\fpadding\2\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    after = { "neogen" },
    config = { "\27LJ\2\2Œ\2\0\0\3\0\f\0!6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\0016\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\a\0005\2\6\0=\2\5\1B\0\2\0016\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\t\0005\2\b\0=\2\5\1B\0\2\0016\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\v\0005\2\n\0=\2\5\1B\0\2\1K\0\1\0\1\0\0\1\2\0\0?~/.local/share/nvim/site/pack/packer/opt/friendly-snippets\1\0\0\1\2\0\0\26./snippets/typescript\1\0\0\1\2\0\0\20./snippets/rust\npaths\1\0\0\1\2\0\0\22./snippets/python\14lazy_load luasnip.loaders.from_vscode\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\2:\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\31doodleVim.modules.ui.alpha\frequire\0" },
    loaded = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["auto-session"] = {
    config = { "\27LJ\2\2œ\3\0\0\5\0\17\0\0286\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\1\5\0B\0\2\0029\0\6\0005\1\a\0006\2\0\0009\2\b\0029\2\t\2'\3\n\0B\2\2\2'\3\v\0&\2\3\2=\2\f\0014\2\0\0=\2\r\0014\2\3\0006\3\4\0'\4\14\0B\3\2\0029\3\15\3>\3\1\2=\2\16\1B\0\2\1K\0\1\0\22post_restore_cmds\vtoggle\26doodleVim.extend.tree\31auto_session_suppress_dirs\26auto_session_root_dir\15/sessions/\tdata\fstdpath\afn\1\0\5%auto_session_enable_last_session\1\14log_level\tinfo\22auto_save_enabled\1\25auto_restore_enabled\1\25auto_session_enabled\1\nsetup\17auto-session\frequire>buffers,curdir,folds,help,tabpages,winsize,winpos,globals\19sessionoptions\6o\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["barbar.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\2ñ\1\0\0\3\0\n\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0016\2\6\0009\2\a\0029\2\b\2=\2\t\1B\0\2\1K\0\1\0\ftimeout\15timeoutlen\6o\bvim\fmapping\1\0\1\tkeys\n<ESC>\1\5\0\0\aii\ajj\ajk\akj\nsetup\18better_escape\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-look"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-look/after/plugin/cmp_look.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-look",
    url = "https://github.com/octaltree/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tabnine"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-tabnine/after/plugin/cmp-tabnine.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  cmp_luasnip = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot-cmp"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/copilot-cmp/after/plugin/copilot_cmp.lua" },
    load_after = {
      ["copilot.lua"] = true,
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    after = { "copilot-cmp" },
    config = { "\27LJ\2\0025\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fcopilot\frequire-\1\0\3\0\3\0\0066\0\0\0009\0\1\0003\1\2\0)\2»\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["copilot.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\2X\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\ttext\1\0\0\1\0\1\fspinner\tmoon\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["friendly-snippets"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/cinuor/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\2˚\2\0\0\3\0\n\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\6\0=\2\a\0015\2\b\0=\2\t\1B\0\2\1K\0\1\0\19preview_config\1\0\5\brow\3\0\rrelative\vcursor\nstyle\fminimal\bcol\3\1\vborder\vsingle\28current_line_blame_opts\1\0\4\14virt_text\2\ndelay\3»\1\18virt_text_pos\beol\22ignore_whitespace\1\17watch_gitdir\1\0\2!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\23current_line_blame\1\1\0\2\rinterval\3–\15\17follow_files\2\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gotests.nvim"] = {
    config = { "\27LJ\2\2E\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\1\fverbose\1\nsetup\fgotests\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/gotests.nvim",
    url = "https://github.com/cinuor/gotests.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/gruvbox.nvim",
    url = "https://github.com/cinuor/gruvbox.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\0021\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\bhop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\2W\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\1\21show_end_of_line\2\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lightspeed.nvim"] = {
    keys = { { "", "s" }, { "", "S" }, { "", "f" }, { "", "F" }, { "", "t" }, { "", "T" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lsp_signature.nvim"] = {
    after = { "nvim-lsp-installer" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\2C\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0(doodleVim.modules.ui.lualine_config\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  neogen = {
    config = { "\27LJ\2\2R\0\0\2\0\4\0\a6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\1K\0\1\0\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0" },
    load_after = {
      LuaSnip = true,
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\2∆\1\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\rmappings\1\0\6\24use_local_scrolloff\1\22respect_scrolloff\1\16hide_cursor\1\25cursor_scrolls_alone\2\rstop_eof\2\21performance_mode\1\1\3\0\0\n<C-f>\n<C-b>\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nui.nvim"] = {
    after = { "rename.nvim" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\2Ï\2\0\0\5\0\18\0\0266\0\0\0'\1\1\0B\0\2\0029\1\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\0039\3\t\3=\3\n\0025\3\v\0=\3\f\0024\3\3\0009\4\r\0009\4\14\0049\4\15\4>\4\1\0039\4\r\0009\4\14\0049\4\16\4>\4\2\3=\3\17\2B\1\2\1K\0\1\0\fsources\nblack\rprettier\15formatting\rbuiltins\blog\1\0\3\16use_console\nasync\nlevel\twarn\venable\2\22fallback_severity\nERROR\rseverity\15diagnostic\bvim\bcmd\1\0\5\rdebounce\3˙\1\ndebug\1\20default_timeout\3à'\23diagnostics_format\t#{m}\21update_in_insert\1\1\2\0\0\tnvim\nsetup\fnull-ls\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\2§\2\0\0\b\0\15\0\0296\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\0016\0\0\0'\1\4\0B\0\2\0026\1\0\0'\2\5\0B\1\2\0029\1\6\0014\2\0\0B\1\2\0016\1\0\0'\2\a\0B\1\2\0029\2\b\0\18\3\2\0009\2\t\2'\4\n\0009\5\v\0015\6\r\0005\a\f\0=\a\14\6B\5\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\nsetup\19nvim-autopairs\bcmp\rnvim-cmp\21load_immediately\26doodleVim.utils.defer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-nvim-lsp", "copilot-cmp", "nvim-lspconfig", "cmp-buffer", "cmp_luasnip", "LuaSnip", "cmp-look", "cmp-cmdline", "copilot.lua", "cmp-tabnine", "cmp-path", "neogen" },
    config = { "\27LJ\2\2Í\1\0\0\4\0\t\0&+\0\1\0\14\0\0\0X\1\vÄ6\1\0\0009\1\1\0019\1\2\1)\2\0\0'\3\3\0B\1\3\2\6\1\4\0X\1\2Ä+\0\1\0X\1\1Ä+\0\2\0\14\0\0\0X\1\tÄ6\1\0\0009\1\5\0019\1\6\1B\1\1\2\a\1\a\0X\1\2Ä+\0\1\0X\1\1Ä+\0\2\0\14\0\0\0X\1\tÄ6\1\0\0009\1\5\0019\1\b\1B\1\1\2\a\1\a\0X\1\2Ä+\0\1\0X\1\1Ä+\0\2\0\19\1\0\0L\1\2\0\18reg_executing\5\18reg_recording\afn\vprompt\fbuftype\24nvim_buf_get_option\bapi\bvimC\0\1\3\0\4\0\a6\1\0\0'\2\1\0B\1\2\0029\1\2\0019\2\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire∂\1\0\1\3\0\6\0 6\1\0\0'\2\1\0B\1\2\0029\1\2\1)\2ˇˇB\1\2\2\15\0\1\0X\2\aÄ6\1\0\0'\2\1\0B\1\2\0029\1\3\1)\2ˇˇB\1\2\1X\1\16Ä6\1\0\0'\2\4\0B\1\2\0029\1\2\1+\2\2\0B\1\2\2\15\0\1\0X\2\6Ä6\1\0\0'\2\4\0B\1\2\0029\1\5\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\14jump_prev\vneogen\tjump\rjumpable\fluasnip\frequire«\1\0\1\3\0\a\0\0296\1\0\0'\2\1\0B\1\2\0029\1\2\1B\1\1\2\15\0\1\0X\2\6Ä6\1\0\0'\2\1\0B\1\2\0029\1\3\1B\1\1\1X\1\15Ä6\1\0\0'\2\4\0B\1\2\0029\1\5\1B\1\1\2\15\0\1\0X\2\6Ä6\1\0\0'\2\4\0B\1\2\0029\1\6\1B\1\1\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\14jump_next\rjumpable\vneogen\19expand_or_jump\23expand_or_jumpable\fluasnip\frequireQ\0\1\3\1\2\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\2\2\0B\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\16scroll_docs\fvisibleQ\0\1\3\1\2\0\r-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\5Ä-\1\0\0009\1\1\1)\2˛ˇB\1\2\1X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\0¿\16scroll_docs\fvisible \2\0\2\b\0\14\0\"9\2\0\0016\3\1\0009\3\2\3\18\4\2\0)\5ˇˇ)\6ˇˇB\3\4\2\a\3\3\0X\3\aÄ6\3\1\0009\3\2\3\18\4\2\0)\5\0\0)\6˛ˇB\3\4\2=\3\0\0016\3\4\0'\4\5\0B\3\2\0026\4\1\0009\4\a\4'\5\b\0009\6\t\0039\a\6\0018\6\a\0069\a\6\1B\4\4\2=\4\6\0015\4\v\0009\5\f\0009\5\r\0058\4\5\4=\4\n\1L\1\2\0\tname\vsource\1\0\a\tlook\v[LOOK]\tpath\v[PATH]\rnvim_lsp\n[LSP]\vbuffer\n[BUF]\16cmp_tabnine\n[TAB]\fcopilot\t[AI]\fluasnip\n[SNP]\tmenu\bcmp\n%s %s\vformat\tkind\26doodleVim.utils.icons\frequire\6~\bsub\vstring\tabbrÎ\14\1\0\f\0h\0›\0016\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\0016\0\0\0'\1\4\0B\0\2\0026\1\0\0'\2\5\0B\1\2\0026\2\0\0'\3\6\0B\2\2\0029\3\a\0005\4\t\0003\5\b\0=\5\n\0045\5\f\0003\6\v\0=\6\r\5=\5\14\0045\5\19\0009\6\15\0009\6\16\0069\6\17\0065\a\18\0B\6\2\2=\6\20\0059\6\15\0009\6\16\0069\6\17\0065\a\21\0B\6\2\2=\6\22\5=\5\16\0049\5\15\0009\5\23\0054\6\b\0005\a\24\0>\a\1\0065\a\25\0>\a\2\0065\a\26\0>\a\3\0065\a\27\0>\a\4\0065\a\28\0>\a\5\0065\a\29\0>\a\6\0065\a\30\0005\b\31\0=\b \a>\a\a\6B\5\2\2=\5\23\0049\5!\0009\5\"\0059\5#\0055\6+\0005\a)\0009\b!\0009\b$\b5\t'\0009\n\4\0019\n%\n9\n&\n=\n(\tB\b\2\2=\b*\a=\a,\0065\a/\0009\b!\0009\b-\b5\t.\0009\n\4\0019\n%\n9\n&\n=\n(\tB\b\2\2=\b*\a=\a0\0065\a3\0009\b!\0009\b$\b5\t2\0009\n\4\0019\n%\n9\n1\n=\n(\tB\b\2\2=\b*\a=\a4\0065\a6\0009\b!\0009\b-\b5\t5\0009\n\4\0019\n%\n9\n1\n=\n(\tB\b\2\2=\b*\a=\a7\0065\a:\0009\b!\0009\b8\b5\t9\0B\b\2\2=\b*\a=\a;\0065\a=\0009\b!\0009\b<\bB\b\1\2=\b*\a=\a>\0069\a!\0003\b?\0005\t@\0B\a\3\2=\aA\0069\a!\0003\bB\0005\tC\0B\a\3\2=\aD\0069\a!\0003\bE\0005\tF\0B\a\3\2=\aG\0069\a!\0003\bH\0005\tI\0B\a\3\2=\aJ\6B\5\2\2=\5!\0045\5L\0005\6K\0=\6M\5=\5N\0045\5S\0004\6\4\0009\aO\0009\aP\a>\a\1\0069\aO\0009\aQ\a>\a\2\0069\aO\0009\aR\a>\a\3\6=\6T\0053\6U\0=\6V\5=\5W\4B\3\2\0019\3\a\0009\3X\3'\4Y\0005\5[\0009\6\15\0009\6\23\0064\a\3\0005\bZ\0>\b\1\aB\6\2\2=\6\23\5B\3\3\0019\3\a\0009\3\\\3'\4]\0005\5^\0009\6!\0009\6\"\0069\6\\\6B\6\1\2=\6!\0054\6\3\0005\a_\0>\a\1\6=\6\23\5B\3\3\0019\3\a\0009\3\\\3'\4`\0005\5e\0009\6!\0009\6\"\0069\6\\\0065\ad\0005\bb\0009\t!\0009\t$\t5\na\0009\v\4\0019\v%\v9\v1\v=\v(\nB\t\2\2=\tc\b=\b,\aB\6\2\2=\6!\0059\6\15\0009\6\23\0064\a\3\0005\bf\0>\b\1\a4\b\3\0005\tg\0>\t\1\bB\6\3\2=\6\23\5B\3\3\0012\0\0ÄK\0\1\0\1\0\1\tname\tpath\1\0\1\tname\fcmdline\1\0\0\1\0\0\6c\1\0\0\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6/\fcmdline\1\0\0\1\0\1\tname\tpath\20TelescopePrompt\rfiletype\15formatting\vformat\0\vfields\1\0\0\tMenu\tKind\tAbbr\14ItemField\tview\fentries\1\0\0\1\0\2\20selection_order\rtop_down\tname\vcustom\n<C-u>\1\3\0\0\6i\6s\0\n<C-d>\1\3\0\0\6i\6s\0\n<C-j>\1\3\0\0\6i\6s\0\n<C-k>\1\3\0\0\6i\6s\0\n<C-e>\1\0\0\nabort\t<CR>\1\0\0\1\0\1\vselect\2\fconfirm\n<C-p>\1\0\0\1\0\0\n<C-n>\1\0\0\1\0\0\vInsert\t<Up>\1\0\0\1\0\0\21select_prev_item\v<Down>\1\0\0\6i\1\0\0\rbehavior\1\0\0\vSelect\19SelectBehavior\21select_next_item\vinsert\vpreset\fmapping\voption\1\0\2\tloud\2\17convert_case\2\1\0\2\19keyword_length\3\2\tname\tlook\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\fcopilot\1\0\1\tname\16cmp_tabnine\1\0\2\rpriority\3c\tname\rnvim_lsp\1\0\2\rpriority\3d\tname\fluasnip\fsources\18documentation\1\0\1\17winhighlightJNormal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None\15completion\1\0\0\1\0\1\17winhighlightJNormal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None\rbordered\vwindow\vconfig\fsnippet\vexpand\1\0\0\0\fenabled\1\0\0\0\nsetup\vneogen\14cmp.types\bcmp\1\3\0\0\fLuaSnip\vneogen\21load_immediately\26doodleVim.utils.defer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\0027\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui" },
    config = { "\27LJ\2\2Ÿ\2\0\0\3\0\r\0\0256\0\0\0009\0\1\0009\0\2\0'\1\3\0005\2\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\1\5\0005\2\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\1\a\0005\2\b\0B\0\3\0016\0\t\0'\1\n\0B\0\2\0029\0\v\0005\1\f\0B\0\2\1K\0\1\0\1\3\0\0\ago\vpython\19load_debuggers\30doodleVim.extend.debugger\frequire\1\0\4\vtexthl\5\ttext\v‚≠êÔ∏è\vlinehl\5\nnumhl\5\26DapBreakpointRejected\1\0\4\vtexthl\5\ttext\bÔó£\vlinehl\5\nnumhl\5\15DapStopped\1\0\4\vtexthl\5\ttext\tüî¥\vlinehl\5\nnumhl\5\18DapBreakpoint\16sign_define\afn\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\2\30\0\0\1\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\topen\31\0\0\1\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose\31\0\0\1\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose\31\0\0\1\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\ncloseö\6\1\0\5\0(\0@6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\0015\2\a\0005\3\6\0=\3\b\2=\2\t\0015\2\14\0004\3\5\0005\4\n\0>\4\1\0035\4\v\0>\4\2\0035\4\f\0>\4\3\0035\4\r\0>\4\4\3=\3\15\2=\2\16\0015\2\18\0005\3\17\0=\3\15\2=\2\19\0015\2\20\0005\3\22\0005\4\21\0=\4\23\3=\3\t\2=\2\24\0015\2\25\0=\2\26\1B\0\2\0016\0\0\0'\1\27\0B\0\2\0026\1\0\0'\2\1\0B\1\2\0029\2\28\0009\2\29\0029\2\30\0023\3 \0=\3\31\0029\2\28\0009\2!\0029\2\"\0023\3#\0=\3\31\0029\2\28\0009\2!\0029\2$\0023\3%\0=\3\31\0029\2\28\0009\2!\0029\2&\0023\3'\0=\3\31\0022\0\0ÄK\0\1\0\0\15disconnect\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\bdap\fwindows\1\0\1\vindent\3\1\rfloating\nclose\1\0\0\1\3\0\0\6q\n<Esc>\1\0\3\15max_height\4ö≥ÊÃ\tô≥Ê˛\3\14max_width\4ö≥ÊÃ\tô≥Ê˛\3\vborder\vsingle\ttray\1\0\2\tsize\3\n\rposition\vbottom\1\2\0\0\trepl\fsidebar\relements\1\0\2\tsize\3(\rposition\tleft\1\0\2\aid\fwatches\tsize\4\0ÄÄ¿˛\3\1\0\2\aid\vstacks\tsize\4\0ÄÄ¿˛\3\1\0\2\aid\16breakpoints\tsize\4\0ÄÄ¿˛\3\1\0\2\aid\vscopes\tsize\4\0ÄÄ¿˛\3\rmappings\vexpand\1\0\4\topen\6o\trepl\6r\tedit\6e\vremove\6d\1\3\0\0\t<CR>\18<2-LeftMouse>\nicons\1\0\0\1\0\2\14collapsed\b‚ñ∏\rexpanded\b‚ñæ\nsetup\ndapui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\2¢\2\0\0\4\0\14\0\0196\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0004\2\0\0=\2\4\0015\2\5\0=\2\6\0015\2\a\0004\3\0\0=\3\b\2=\2\t\0015\2\n\0=\2\v\0015\2\f\0=\2\r\1B\0\2\1K\0\1\0\16status_text\1\0\3\ttext\tüí°\21text_unavailable\5\fenabled\1\17virtual_text\1\0\3\ttext\tüí°\fhl_mode\freplace\fenabled\1\nfloat\rwin_opts\1\0\2\ttext\tüí°\fenabled\1\tsign\1\0\2\fenabled\2\rpriority\3\20\vignore\1\0\0\nsetup\19nvim-lightbulb\frequire\0" },
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lsp-installer"] = {
    config = { "\27LJ\2\2¸\1\0\2\6\0\v\0\0176\2\0\0009\2\1\0029\2\2\2\18\3\1\0'\4\3\0'\5\4\0B\2\4\0016\2\5\0'\3\6\0B\2\2\0029\2\a\0025\3\b\0005\4\t\0=\4\n\3\18\4\1\0B\2\3\1K\0\1\0\17handler_opts\1\0\1\vborder\frounded\1\0\3\16hint_enable\1#floating_window_above_cur_line\2\tbind\2\14on_attach\18lsp_signature\frequire\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvimØ\t\1\0\17\0004\0r5\0\0\0006\1\1\0'\2\2\0B\1\2\0029\1\3\0015\2\4\0B\1\2\0016\1\1\0'\2\5\0B\1\2\0029\1\6\1'\2\a\0B\1\2\0016\1\1\0'\2\b\0B\1\2\0026\2\t\0009\2\n\0029\2\v\0026\3\t\0009\3\n\0039\3\r\0036\4\t\0009\4\n\0049\4\v\0049\4\14\0045\5\15\0B\3\3\2=\3\f\0026\2\t\0009\2\16\0029\2\17\0025\3\18\0005\4\19\0004\5\3\0009\6\20\0019\6\21\6'\a\22\0&\6\a\6>\6\1\5=\5\23\4=\4\24\0035\4\25\0005\5\28\0006\6\t\0009\6\16\0069\6\26\0069\6\27\6=\6\29\5=\5\26\4=\4\30\3B\2\2\0019\2\20\0016\3\1\0'\4\31\0B\3\2\0029\3\3\0035\4!\0009\5 \2=\5 \0049\5\"\2=\5\"\0049\5#\2=\5#\0049\5$\2=\5$\0049\5\21\2=\5\21\4B\3\2\0016\3\t\0009\3\n\0039\3%\0039\3&\3B\3\1\0026\4\1\0'\5'\0B\4\2\0029\4(\4\18\5\3\0B\4\2\2\18\3\4\0003\4)\0006\5\1\0'\6*\0B\5\2\0026\6+\0\18\a\0\0B\6\2\4X\t\22Ä6\v\1\0'\f,\0B\v\2\0029\v-\v\18\f\n\0B\v\2\3\14\0\v\0X\r\3Ä\18\14\f\0009\r.\fB\r\2\1\18\14\f\0009\r/\fB\r\2\0028\14\n\0059\14\3\0145\0151\0009\0160\r=\0160\15=\0042\15=\0033\15B\14\2\1E\t\3\3R\tË\127K\0\1\0\17capabilities\14on_attach\1\0\0\fcmd_env\24get_default_options\finstall\15get_server\31nvim-lsp-installer.servers\vipairs\14lspconfig\0\24update_capabilities\17cmp_nvim_lsp\29make_client_capabilities\rprotocol\15infor_sign\14hint_sign\14warn_sign\1\0\1 use_diagnostic_virtual_text\1\15error_sign!doodleVim.extend.diagnostics\17virtual_text\bmin\1\0\0\tHINT\rseverity\1\0\2\vsource\valways\fspacing\3\4\nfloat\vheader\18 Diagnostics:\15debug_sign\tdiag\1\0\3\14focusable\1\vsource\valways\vborder\frounded\1\0\4\18severity_sort\2\14underline\2\nsigns\2\21update_in_insert\1\vconfig\15diagnostic\1\0\1\vborder\frounded\nhover\twith\23textDocument/hover\rhandlers\blsp\bvim\26doodleVim.utils.icons\17cmp-nvim-lsp\21load_immediately\26doodleVim.utils.defer\1\0\1\27automatic_installation\2\nsetup\23nvim-lsp-installer\frequire\1\4\0\0\ngopls\fpyright\16sumneko_lua\0" },
    load_after = {
      ["lsp_signature.nvim"] = true,
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "rename.nvim", "nvim-lsp-installer", "null-ls.nvim", "lsp_signature.nvim", "nui.nvim" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\2O\0\1\4\0\4\1\f6\1\0\0009\1\1\0019\1\2\1\18\2\0\0'\3\3\0B\1\3\2\t\1\0\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\n^\\s*$\nmatch\afn\bvim˛ˇˇˇ\31J\0\2\t\0\1\0\0156\2\0\0\18\3\0\0B\2\2\4X\5\aÄ\18\a\1\0\18\b\6\0B\a\2\2\14\0\a\0X\a\2Ä+\a\1\0L\a\2\0E\5\3\3R\5˜\127+\2\2\0L\2\2\0\vipairs9\0\1\4\2\2\0\a-\1\0\0009\2\0\0009\2\1\2-\3\1\0B\1\3\2\19\1\1\0L\1\2\0\1¿\0¿\16regcontents\nevent¸\4\1\0\b\0\29\0&3\0\0\0003\1\1\0006\2\2\0'\3\3\0B\2\2\0029\2\4\0025\3\5\0006\4\6\0009\4\a\0049\4\b\4'\5\t\0B\4\2\2'\5\n\0&\4\5\4=\4\v\0033\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\26\0005\5\22\0005\6\20\0004\a\0\0=\a\21\6=\6\23\0055\6\24\0004\a\0\0=\a\21\6=\6\25\5=\5\27\4=\4\28\3B\2\2\0012\0\0ÄK\0\1\0\tkeys\14telescope\1\0\0\6n\1\0\5\vdelete\6d\17paste_behind\6P\vselect\t<cr>\vreplay\6z\npaste\6p\6i\1\0\0\vcustom\1\0\5\vdelete\n<c-d>\17paste_behind\n<c-k>\vselect\t<cr>\vreplay\n<c-z>\npaste\n<c-p>\14on_replay\1\0\1\fset_reg\1\ron_paste\1\0\1\fset_reg\1\21default_register\1\4\0\0\6\"\6+\6*\vfilter\0\fdb_path\31/databases/neoclip.sqlite3\tdata\fstdpath\afn\bvim\1\0\b\28default_register_macros\6z\30enable_persistent_history\2\fhistory\0032\20continuous_sync\2\25enable_macro_history\1\28enable_system_clipboard\2\fpreview\2\24content_spec_column\1\nsetup\fneoclip\frequire\0\0\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\2í\3\0\0\6\0\21\0!6\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\2\0B\1\2\0029\2\3\0015\3\4\0005\4\a\0009\5\5\0009\5\6\5=\5\b\0049\5\5\0009\5\t\5=\5\n\0049\5\5\0009\5\v\5=\5\f\0049\5\5\0009\5\r\5=\5\14\0049\5\5\0009\5\15\5=\5\16\4=\4\17\3B\2\2\0016\2\18\0006\3\0\0'\4\19\0B\3\2\0029\3\20\3=\3\2\2K\0\1\0\19wrapped_notify\26doodleVim.extend.misc\bvim\nicons\nTRACE\15trace_sign\nDEBUG\15debug_sign\tINFO\15infor_sign\tWARN\14warn_sign\nERROR\1\0\0\15error_sign\tdiag\1\0\5\22background_colour\vNormal\ftimeout\3–\15\vstages\nslide\18minimum_width\3$\vrender\fdefault\nsetup\vnotify\26doodleVim.utils.icons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\0027\0\1\4\0\4\0\a6\1\0\0009\1\1\1'\2\2\0009\3\3\0&\2\3\2B\1\2\1K\0\1\0\nfname\nedit \bcmd\bvim˜\t\1\0\b\0005\0D6\0\0\0'\1\1\0B\0\2\0026\1\0\0'\2\2\0B\1\2\0029\1\3\0015\2\4\0005\3\5\0005\4\6\0004\5\0\0=\5\a\4=\4\b\3=\3\t\0024\3\0\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0004\4\0\0=\4\14\3=\3\15\0025\3\16\0005\4\19\0009\5\17\0009\5\18\5=\5\20\0049\5\17\0009\5\21\5=\5\22\0049\5\17\0009\5\23\5=\5\24\0049\5\17\0009\5\25\5=\5\26\4=\4\27\3=\3\28\0025\3\29\0005\4\30\0=\4\31\0035\4 \0005\5!\0005\6#\0005\a\"\0=\a$\0065\a%\0=\a&\6=\6'\5=\5(\4=\4)\3=\3*\0025\3+\0=\3,\0025\3-\0=\3.\0025\3/\0004\4\0\0=\0040\3=\0031\2B\1\2\0016\1\0\0'\0022\0B\1\2\0029\0013\0013\0024\0B\1\2\1K\0\1\0\0\20on_file_created\21nvim-tree.events\16system_open\targs\1\0\0\ntrash\1\0\2\bcmd\ntrash\20require_confirm\2\bgit\1\0\3\vignore\1\ftimeout\3ê\3\venable\2\factions\14open_file\18window_picker\fexclude\fbuftype\1\4\0\0\vnofile\rterminal\thelp\rfiletype\1\0\0\1\a\0\0\vnotify\vpacker\aqf\tdiff\rfugitive\18fugitiveblame\1\0\2\nchars)ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\venable\2\1\0\2\18resize_window\1\17quit_on_open\1\15change_dir\1\0\2\vglobal\1\venable\2\1\0\1\25use_system_clipboard\2\16diagnostics\nicons\nerror\15error_sign\fwarning\14warn_sign\tinfo\15infor_sign\thint\1\0\0\14hint_sign\tdiag\1\0\2\17show_on_dirs\2\venable\2\24update_focused_file\16ignore_list\1\0\2\15update_cwd\2\venable\2\23hijack_directories\1\0\2\14auto_open\2\venable\2\23ignore_ft_on_setup\tview\rmappings\tlist\1\0\1\16custom_only\1\1\0\a\tside\tleft\vheight\3\31\vnumber\1\19relativenumber\1\15signcolumn\byes\nwidth\3\31 preserve_window_proportions\2\1\0\n\fsort_by\tname\18open_on_setup\1'hijack_unnamed_buffer_when_opening\1\18disable_netrw\2\16open_on_tab\1\25auto_reload_on_write\2\18hijack_cursor\2\17hijack_netrw\2\15update_cwd\2\27ignore_buffer_on_setup\1\nsetup\14nvim-tree\26doodleVim.utils.icons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\2ı\4\0\0\5\0\17\0\0236\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0B\0\2\0016\0\0\0'\1\4\0B\0\2\0029\0\5\0005\1\a\0005\2\6\0=\2\b\0015\2\t\0=\2\n\0015\2\14\0005\3\v\0005\4\f\0=\4\r\3=\3\15\2=\2\16\1B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\fkeymaps\1\0\v\ail\16@loop.inner\aas\21@statement.outer\aib\17@block.inner\aaf\20@function.outer\aac\17@class.outer\aif\20@function.inner\aal\16@loop.outer\aah\16@call.outer\aab\17@block.outer\aic\17@class.inner\aih\16@call.inner\1\0\2\14lookahead\2\venable\2\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\21ensure_installed\1\0\0\1\21\0\0\tbash\ncmake\fcomment\6c\bcpp\bdot\15dockerfile\ago\ngomod\vgowork\nhjson\thtml\blua\tmake\vpython\nregex\trust\ttoml\bvim\tyaml\nsetup\28nvim-treesitter.configs nvim-treesitter-textobjects\21load_immediately\26doodleVim.utils.defer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\2 \6\0\2\14\0$\1]6\2\0\0'\3\1\0B\2\2\0026\3\0\0'\4\2\0B\3\2\0029\4\3\3B\4\1\0029\5\4\2B\5\1\2'\6\5\0009\a\6\0039\a\a\a\15\0\a\0X\b\24Ä6\a\b\0009\a\t\a9\a\n\a'\b\v\0B\a\2\0026\b\b\0009\b\f\b9\b\r\b\b\b\0\0X\b\rÄ6\b\b\0009\b\14\b9\b\15\b6\t\16\0009\t\17\t'\n\18\0006\v\19\0009\v\20\v\18\f\a\0'\r\21\0B\v\3\0A\t\1\0A\b\0\1:\6\1\a9\a\22\2\6\6\5\0X\b\5Ä'\b\23\0\18\t\6\0&\b\t\b\14\0\b\0X\t\1Ä'\b\5\0B\a\2\2\18\6\a\0006\a\16\0009\a\17\a'\b\24\0\18\t\5\0\18\n\6\0B\a\4\2\18\5\a\0006\a\16\0009\a\17\a\18\b\4\0'\t\25\0&\b\t\b\18\t\5\0B\a\3\0029\b\26\2\18\t\a\0B\b\2\2\15\0\b\0X\t\tÄ6\b\b\0009\b\27\b'\t\28\0B\b\2\0016\b\b\0009\b\29\b'\t\30\0B\b\2\1X\b\14Ä6\b\b\0009\b\27\b'\t\31\0B\b\2\0016\b\0\0'\t \0B\b\2\0029\b!\bB\b\1\0016\b\b\0009\b\29\b'\t\"\0'\n#\0B\b\3\1K\0\1\0\twarn*No Session Found, Open In Current Dir\vtoggle\26doodleVim.extend.tree\t:ene\27Current Session Loaded\vnotify9silent! lua require('auto-session').RestoreSession()\bcmd\16is_readable\v%s.vim\t%s%s\6_\23escape_branch_name\6\n\vconcat\ntable\24git failed with: %s\vformat\vstring\21nvim_err_writeln\bapi\16shell_error\6v$git rev-parse --abbrev-ref HEAD\15systemlist\afn\bvim auto_session_use_git_branch\tconf\5\"escaped_session_name_from_cwd\17get_root_dir\17auto-session\25auto-session-library\frequire\0Ë\2\1\0\4\0\17\0\0236\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\4\0=\2\5\0015\2\6\0=\2\a\0014\2\0\0=\2\b\0014\2\0\0=\2\t\0016\2\n\0009\2\v\0029\2\f\2'\3\r\0B\2\2\2=\2\14\0013\2\15\0=\2\16\1B\0\2\1K\0\1\0\"telescope_on_project_selected\0\rdatapath\tdata\fstdpath\afn\bvim\17exclude_dirs\15ignore_lsp\rpatterns\1\t\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\16poetry.lock\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16show_hidden\1\17silent_chdir\1\16manual_mode\1\nsetup\17project_nvim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/project.nvim",
    url = "https://github.com/cinuor/project.nvim"
  },
  ["rename.nvim"] = {
    config = { "\27LJ\2\2œ\1\0\0\4\0\a\0\v6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\6\0005\2\4\0005\3\3\0=\3\5\2=\2\1\1B\0\2\1K\0\1\0\1\0\0\vborder\1\0\2\vprompt\t‚û§ \14prompt_hl\fComment\1\0\5\rtitle_hl\16FloatBorder\nstyle\frounded\14highlight\16FloatBorder\16title_align\tleft\ntitle\r Rename \nsetup\vrename\frequire\0" },
    load_after = {
      ["nui.nvim"] = true,
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/rename.nvim",
    url = "https://github.com/cinuor/rename.nvim"
  },
  ["sqlite.lua"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["symbols-outline.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    load_after = {
      ["telescope.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    after = { "telescope-ui-select.nvim", "telescope-file-browser.nvim", "nvim-lightbulb", "telescope-fzy-native.nvim" },
    config = { "\27LJ\2\2Ω\16\0\0\b\0S\1†\0016\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0B\0\2\0016\0\0\0'\1\4\0B\0\2\0026\1\0\0'\2\5\0B\1\2\0026\2\0\0'\3\6\0B\2\2\0029\2\a\0025\3?\0005\4\b\0005\5\t\0=\5\n\0045\5\14\0005\6\v\0005\a\f\0=\a\r\6=\6\15\5=\5\16\0045\5\17\0=\5\18\0045\5\20\0005\6\19\0=\6\21\0055\6\22\0=\6\23\5=\5\24\0045\5\25\0=\5\26\0045\0058\0005\6\28\0009\a\27\0=\a\29\0069\a\30\0=\a\31\0069\a\27\0=\a \0069\a\30\0=\a!\0069\a\"\0=\a#\0069\a$\0=\a%\0069\a&\0=\a'\0069\a(\0=\a)\0069\a*\0=\a+\0069\a,\0=\a-\0069\a.\0=\a/\0069\a0\0=\a1\0069\a2\1=\a3\0069\a4\0=\a5\0069\a6\0=\a7\6=\0069\0055\6:\0009\a\27\0=\a;\0069\a\30\0=\a<\0069\a\27\0=\a \0069\a\30\0=\a!\0069\a\"\0=\a#\0069\a$\0=\a%\0069\a&\0=\a'\0069\a(\0=\a)\0069\a*\0=\a+\0069\a,\0=\a-\0069\a.\0=\a/\0069\a0\0=\a1\0069\a2\1=\a3\0069\a4\0=\a5\0069\a6\0=\a7\6=\6=\5=\5>\4=\4@\0035\4B\0005\5A\0=\5C\0044\5\3\0006\6\0\0'\aD\0B\6\2\0029\6E\0064\a\0\0B\6\2\0?\6\0\0=\5F\4=\4G\0035\4K\0005\5I\0005\6H\0=\6J\5=\5L\4=\4M\3B\2\2\0016\2\0\0'\3\6\0B\2\2\0029\2N\2'\3C\0B\2\2\0016\2\0\0'\3\6\0B\2\2\0029\2N\2'\3O\0B\2\2\0016\2\0\0'\3\6\0B\2\2\0029\2N\2'\3P\0B\2\2\0016\2\0\0'\3\6\0B\2\2\0029\2N\2'\3Q\0B\2\2\0016\2\0\0'\3\6\0B\2\2\0029\2N\2'\3R\0B\2\2\0016\2\0\0'\3\6\0B\2\2\0029\2N\2'\3F\0B\2\2\1K\0\1\0\fneoclip\rprojects\18todo-comments\17file_browser\19load_extension\fpickers\15find_files\1\0\0\17find_command\1\0\0\1\5\0\0\afd\v--type\6f\23--strip-cwd-prefix\15extensions\14ui-select\17get_dropdown\21telescope.themes\15fzy_native\1\0\0\1\0\2\28override_generic_sorter\2\25override_file_sorter\2\rdefaults\1\0\0\21default_mappings\6n\6k\6j\1\0\0\6i\1\0\0\n<C-c>\nclose\14<C-Space>\14which_key\n<Tab>\19toggle_preview\n<C-f>\27results_scrolling_down\n<C-b>\25results_scrolling_up\n<C-d>\27preview_scrolling_down\n<C-u>\25preview_scrolling_up\n<C-t>\15select_tab\n<C-v>\20select_vertical\n<C-x>\22select_horizontal\t<CR>\19select_default\t<Up>\v<Down>\n<C-k>\28move_selection_previous\n<C-j>\1\0\0\24move_selection_next\fpreview\1\0\1\20hide_on_startup\1\18layout_config\rvertical\1\0\4\20prompt_position\btop\vheight\4Õô≥Ê\fÃô≥ˇ\3\nwidth\4Õô≥Ê\fÃô≥ˇ\3\19preview_cutoff\3(\15horizontal\1\0\0\1\0\5\18preview_width\4Õô≥Ê\fÃôÛ˛\3\vheight\4Õô≥Ê\fÃô≥ˇ\3\20prompt_position\btop\19preview_cutoff\3x\nwidth\4Õô≥Ê\fÃô≥ˇ\3\22vimgrep_arguments\1\t\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\v--trim\17path_display\fshorten\1\0\0\fexclude\1\3\0\0\3˛ˇˇˇ\15\3ˇˇˇˇ\15\1\0\1\blen\3\2\fset_env\1\0\1\14COLORTERM\14truecolor\1\0\n\17initial_mode\vnormal\19color_devicons\2\20layout_strategy\tflex\18results_title\fResults\17wrap_results\1\21sorting_strategy\14ascending\18prompt_prefix\5\20scroll_strategy\ncycle\17prompt_title\vPrompt\20selection_caret\tÔÅ° \nsetup\14telescope\29telescope.actions.layout\22telescope.actions\1\5\0\0\30telescope-fzy-native.nvim telescope-file-browser.nvim\21nvim-neoclip.lua\29telescope-ui-select.nvim\21load_immediately\26doodleVim.utils.defer\frequire\3ÄÄ¿ô\4\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\2ë\a\0\0\5\0*\00016\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\3\0005\2\a\0005\3\4\0005\4\5\0=\4\6\3=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\0025\3\r\0005\4\14\0=\4\6\3=\3\15\0025\3\16\0005\4\17\0=\4\6\3=\3\18\0025\3\19\0005\4\20\0=\4\6\3=\3\21\2=\2\22\0015\2\23\0004\3\0\0=\3\24\2=\2\25\0015\2\27\0005\3\26\0=\3\28\0025\3\29\0=\3\30\0025\3\31\0=\3 \0025\3!\0=\3\"\0025\3#\0=\3$\2=\2%\0015\2&\0005\3'\0=\3(\2=\2)\1B\0\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fpattern\31\\b(KEYWORDS)(\\s+\\(.*\\)|:)+\fcommand\arg\vcolors\fdefault\1\2\0\0\f#7C3AED\thint\1\2\0\0\f#10B981\tinfo\1\2\0\0\f#2563EB\fwarning\1\2\0\0\f#FBBF24\nerror\1\0\0\1\2\0\0\f#DC2626\14highlight\fexclude\1\0\6\fpattern\".*<(KEYWORDS)\\v(\\s+\\(.*\\)|:)+\fkeyword\twide\17max_line_len\3ê\3\vbefore\5\18comments_only\2\nafter\afg\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ncolor\thint\ticon\tÔ°ß \tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\2\ncolor\fdefault\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ncolor\fwarning\ticon\tÔÅ± \tHACK\1\0\2\ncolor\fwarning\ticon\tÔíê \tTODO\1\0\2\ncolor\tinfo\ticon\tÔÄå \bFIX\1\0\0\balt\1\6\0\0\nFIXME\bBUG\nFIXIT\nISSUE\nERROR\1\0\2\ncolor\nerror\ticon\tÔÜà \1\0\3\18sign_priority\3\b\19merge_keywords\2\nsigns\2\nsetup\18todo-comments\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["venn.nvim"] = {
    commands = { "VBox", "VFill" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-easy-align"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-floaterm"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-helm"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-helm",
    url = "https://github.com/towolf/vim-helm"
  },
  ["vim-matchup"] = {
    after_files = { "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-solidity"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-solidity",
    url = "https://github.com/TovarishFin/vim-solidity"
  },
  ["vim-startuptime"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-startuptime",
    url = "https://github.com/dstein64/vim-startuptime"
  },
  ["vim-translator"] = {
    commands = { "TranslateW" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-translator",
    url = "https://github.com/voldikss/vim-translator"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/start/vim-wakatime",
    url = "https://github.com/wakatime/vim-wakatime"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\2µ\4\0\0\6\0\23\00026\0\0\0'\1\1\0B\0\2\0029\1\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0005\4\b\0=\4\t\0035\4\n\0=\4\v\3=\3\f\2B\1\2\0016\1\0\0'\2\r\0B\1\2\0026\2\0\0'\3\14\0B\2\2\0026\3\0\0'\4\15\0B\3\2\0029\4\16\0019\5\17\3B\4\2\0019\4\18\0009\5\19\2B\4\2\0019\4\18\0009\5\20\2B\4\2\0019\4\18\0009\5\21\2B\4\2\0019\4\18\0009\5\22\2B\4\2\0019\4\18\0009\5\19\3B\4\2\0019\4\18\0009\5\20\3B\4\2\0019\4\18\0009\5\22\3B\4\2\1K\0\1\0\vvisual\fcommand\vinsert\vnormal\rregister\braw\22nvim_load_mapping\30doodleVim.keymap.plug_map\29doodleVim.keymap.def_map\26doodleVim.keymap.bind\vwindow\fpadding\1\5\0\0\3\2\3\2\3\2\3\2\vmargin\1\5\0\0\3\1\3\0\3\1\3\0\1\0\3\rposition\vbottom\rwinblend\3\0\vborder\vsingle\14operators\15key_labels\1\0\1\19ignore_missing\1\1\0\a\b<a>\bALT\b<c>\bCTR\f<space>\bSPC\t<cr>\bENT\r<leader>\bSPC\b<s>\bSHI\n<tab>\bTAB\nsetup\14which-key\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/yuepeng/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/cinuor/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: hop.nvim
time([[Setup for hop.nvim]], true)
try_loadstring("\27LJ\2\2`\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Ù\1B\0\3\1K\0\1\0\rhop.nvim\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "hop.nvim")
time([[Setup for hop.nvim]], false)
-- Setup for: nvim-treesitter
time([[Setup for nvim-treesitter]], true)
try_loadstring("\27LJ\2\2Y\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2d\0B\0\3\1K\0\1\0\20nvim-treesitter\badd\26doodleVim.utils.defer\frequire\0", "setup", "nvim-treesitter")
time([[Setup for nvim-treesitter]], false)
-- Setup for: vim-floaterm
time([[Setup for vim-floaterm]], true)
try_loadstring("\27LJ\2\2†\1\0\0\3\0\6\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\3\0B\0\2\0029\0\4\0'\1\5\0)\2Ù\1B\0\3\1K\0\1\0\17vim-floaterm\22packer_defer_load\26doodleVim.utils.defer\rfloaterm#doodleVim.modules.tools.config\frequire\0", "setup", "vim-floaterm")
time([[Setup for vim-floaterm]], false)
-- Setup for: which-key.nvim
time([[Setup for which-key.nvim]], true)
try_loadstring("\27LJ\2\2f\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2d\0B\0\3\1K\0\1\0\19which-key.nvim\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "which-key.nvim")
time([[Setup for which-key.nvim]], false)
-- Setup for: barbar.nvim
time([[Setup for barbar.nvim]], true)
try_loadstring("\27LJ\2\2ê\1\0\0\3\0\6\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\3\0B\0\2\0029\0\4\0'\1\5\0)\2d\0B\0\3\1K\0\1\0\16barbar.nvim\badd\26doodleVim.utils.defer\vbarbar$doodleVim.modules.editor.config\frequire\0", "setup", "barbar.nvim")
time([[Setup for barbar.nvim]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\2_\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Z\0B\0\3\1K\0\1\0\26indent-blankline.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: vim-easy-align
time([[Setup for vim-easy-align]], true)
try_loadstring("\27LJ\2\2f\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Ù\1B\0\3\1K\0\1\0\19vim-easy-align\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "vim-easy-align")
time([[Setup for vim-easy-align]], false)
-- Setup for: lualine.nvim
time([[Setup for lualine.nvim]], true)
try_loadstring("\27LJ\2\2V\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Z\0B\0\3\1K\0\1\0\17lualine.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "lualine.nvim")
time([[Setup for lualine.nvim]], false)
-- Setup for: vim-matchup
time([[Setup for vim-matchup]], true)
try_loadstring("\27LJ\2\2c\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2»\0B\0\3\1K\0\1\0\16vim-matchup\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "vim-matchup")
time([[Setup for vim-matchup]], false)
-- Setup for: nvim-autopairs
time([[Setup for nvim-autopairs]], true)
try_loadstring("\27LJ\2\2f\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2»\0B\0\3\1K\0\1\0\19nvim-autopairs\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "nvim-autopairs")
time([[Setup for nvim-autopairs]], false)
-- Setup for: project.nvim
time([[Setup for project.nvim]], true)
try_loadstring("\27LJ\2\2V\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Z\0B\0\3\1K\0\1\0\17project.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "project.nvim")
time([[Setup for project.nvim]], false)
-- Setup for: Comment.nvim
time([[Setup for Comment.nvim]], true)
try_loadstring("\27LJ\2\2d\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2»\0B\0\3\1K\0\1\0\17Comment.nvim\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "Comment.nvim")
time([[Setup for Comment.nvim]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\2X\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2F\0B\0\3\1K\0\1\0\19telescope.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: nvim-dap
time([[Setup for nvim-dap]], true)
try_loadstring("\27LJ\2\2`\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Ë\3B\0\3\1K\0\1\0\rnvim-dap\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "nvim-dap")
time([[Setup for nvim-dap]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\2å\2\0\0\2\0\b\0\0256\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0K\0\1\0&nvim_tree_create_in_closed_folder\26nvim_tree_group_empty\27nvim_tree_add_trailing%nvim_tree_highlight_opened_files\21nvim_tree_git_hl\30nvim_tree_respect_buf_cwd\6g\bvim\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)
-- Setup for: neoscroll.nvim
time([[Setup for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\2X\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2d\0B\0\3\1K\0\1\0\19neoscroll.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "neoscroll.nvim")
time([[Setup for neoscroll.nvim]], false)
-- Setup for: todo-comments.nvim
time([[Setup for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\2\\\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2d\0B\0\3\1K\0\1\0\23todo-comments.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "todo-comments.nvim")
time([[Setup for todo-comments.nvim]], false)
-- Setup for: auto-session
time([[Setup for auto-session]], true)
try_loadstring("\27LJ\2\2V\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2F\0B\0\3\1K\0\1\0\17auto-session\badd\26doodleVim.utils.defer\frequire\0", "setup", "auto-session")
time([[Setup for auto-session]], false)
-- Setup for: gotests.nvim
time([[Setup for gotests.nvim]], true)
try_loadstring("\27LJ\2\2d\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Ë\3B\0\3\1K\0\1\0\17gotests.nvim\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "gotests.nvim")
time([[Setup for gotests.nvim]], false)
-- Setup for: symbols-outline.nvim
time([[Setup for symbols-outline.nvim]], true)
try_loadstring("\27LJ\2\2Ø\1\0\0\3\0\6\0\r6\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\1\3\0B\0\2\0029\0\4\0'\1\5\0)\2Ù\1B\0\3\1K\0\1\0\25symbols-outline.nvim\22packer_defer_load\26doodleVim.utils.defer\20symbols_outline#doodleVim.modules.tools.config\frequire\0", "setup", "symbols-outline.nvim")
time([[Setup for symbols-outline.nvim]], false)
-- Setup for: nvim-neoclip.lua
time([[Setup for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\2Z\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2P\0B\0\3\1K\0\1\0\21nvim-neoclip.lua\badd\26doodleVim.utils.defer\frequire\0", "setup", "nvim-neoclip.lua")
time([[Setup for nvim-neoclip.lua]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\2W\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Z\0B\0\3\1K\0\1\0\18gitsigns.nvim\badd\26doodleVim.utils.defer\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: filetype.nvim
time([[Setup for filetype.nvim]], true)
try_loadstring("\27LJ\2\0024\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\23did_load_filetypes\6g\bvim\0", "setup", "filetype.nvim")
time([[Setup for filetype.nvim]], false)
time([[packadd for filetype.nvim]], true)
vim.cmd [[packadd filetype.nvim]]
time([[packadd for filetype.nvim]], false)
-- Setup for: sqlite.lua
time([[Setup for sqlite.lua]], true)
try_loadstring("\27LJ\2\2T\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2Z\0B\0\3\1K\0\1\0\15sqlite.lua\badd\26doodleVim.utils.defer\frequire\0", "setup", "sqlite.lua")
time([[Setup for sqlite.lua]], false)
-- Setup for: nvim-notify
time([[Setup for nvim-notify]], true)
try_loadstring("\27LJ\2\2c\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\2d\0B\0\3\1K\0\1\0\16nvim-notify\22packer_defer_load\26doodleVim.utils.defer\frequire\0", "setup", "nvim-notify")
time([[Setup for nvim-notify]], false)
-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
try_loadstring("\27LJ\2\2Ö\2\0\0\2\0\n\0\0296\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1à#=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0K\0\1\0\20mkdp_auto_close\28mkdp_command_for_global\26mkdp_echo_preview_url\14mkdp_port\f0.0.0.0\17mkdp_open_ip\27mkdp_open_to_the_world\20mkdp_auto_start\6g\bvim\0", "setup", "markdown-preview.nvim")
time([[Setup for markdown-preview.nvim]], false)
-- Setup for: nvim-cmp
time([[Setup for nvim-cmp]], true)
try_loadstring("\27LJ\2\2R\0\0\3\0\4\0\b6\0\0\0'\1\1\0B\0\2\0029\0\2\0'\1\3\0)\0022\0B\0\3\1K\0\1\0\rnvim-cmp\badd\26doodleVim.utils.defer\frequire\0", "setup", "nvim-cmp")
time([[Setup for nvim-cmp]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\2:\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\31doodleVim.modules.ui.alpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\2X\0\0\3\0\6\0\t6\0\0\0'\1\1\0B\0\2\0029\0\2\0005\1\4\0005\2\3\0=\2\5\1B\0\2\1K\0\1\0\ttext\1\0\0\1\0\1\fspinner\tmoon\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VFill lua require("packer.load")({'venn.nvim'}, { cmd = "VFill", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'vim-startuptime'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file VBox lua require("packer.load")({'venn.nvim'}, { cmd = "VBox", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TranslateW lua require("packer.load")({'vim-translator'}, { cmd = "TranslateW", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> F <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> t <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> f <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> S <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> s <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> T <cmd>lua require("packer.load")({'lightspeed.nvim'}, { keys = "T", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'nvim-colorizer.lua', 'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType solidity ++once lua require("packer.load")({'vim-solidity'}, { ft = "solidity" }, _G.packer_plugins)]]
vim.cmd [[au FileType helm ++once lua require("packer.load")({'vim-helm'}, { ft = "helm" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'better-escape.nvim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'lightspeed.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], true)
vim.cmd [[source /home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]]
time([[Sourcing ftdetect script at: /home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-helm/ftdetect/helm.vim]], false)
time([[Sourcing ftdetect script at: /home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]], true)
vim.cmd [[source /home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]]
time([[Sourcing ftdetect script at: /home/yuepeng/.local/share/nvim/site/pack/packer/opt/vim-solidity/ftdetect/solidity.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

