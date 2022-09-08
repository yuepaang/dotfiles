local bind = require("doodleVim.keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local plug_map = {}

plug_map.raw = {
  ["t|ft"] = map_cmd([[<C-\><C-n>:FloatermToggle<CR>]]):with_noremap():with_silent(), -- floaterm toggle
  ["t|<C-h>"] = map_cmd([[<C-\><C-n>:FloatermPrev<CR>]]):with_noremap():with_silent(), -- previous terminal
  ["t|<C-l>"] = map_cmd([[<C-\><C-n>:FloatermNext<CR>]]):with_noremap():with_silent(), -- next terminal
  ["t|fk"] = map_cmd([[<C-\><C-n>:FloatermKill<CR>]]):with_noremap():with_silent(), -- just kill the front terminal
  ["t|fd"] = map_cmd([[<C-\><C-n>:FloatermKill!<CR>]]):with_noremap():with_silent(), -- kill them all
}

plug_map.normal = {
  ["<leader>"] = {
    name = "leader",
    e = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.tree').toggle()")
        :with_noremap()
        :with_silent()
        :with_label("Enhanced NvimTree Toggle")
    ),
    b = bind.convert_wk_format(map_cmd("<cmd>JABSOpen<cr>"):with_noremap():with_silent():with_label("Buffers")),
  },
  ["t"] = {
    name = "Tree,Translate",
    t = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.tree').toggle()")
        :with_noremap()
        :with_silent()
        :with_label("Enhanced NvimTree Toggle")
    ),
    w = bind.convert_wk_format(
      map_cr("lua ensure_require'nvim-tree.actions.reloaders'.reload_explorer()")
        :with_noremap()
        :with_silent()
        :with_label("NvimTree Refresh")
    ),
    r = bind.convert_wk_format(map_cr("TranslateW"):with_silent():with_label("Translate Word In Cursor")),
  },

  ["g"] = {
    name = "Lsp Function",
    d = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.lsp').lsp_definitions()")
        :with_noremap()
        :with_silent()
        :with_label("Go To Definition")
    ),
    D = bind.convert_wk_format(
      map_cr("lua vim.lsp.buf.declaration()"):with_noremap():with_silent():with_label("Go To Declaration")
    ),
    t = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.lsp').lsp_type_definition()")
        :with_noremap()
        :with_silent()
        :with_label("Go To Type Definition")
    ),
    i = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.lsp').lsp_implementations()")
        :with_noremap()
        :with_silent()
        :with_label("Go To Implementation")
    ),
    r = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.lsp').lsp_references()")
        :with_noremap()
        :with_silent()
        :with_label("Go To Reference")
    ),
    h = bind.convert_wk_format(
      map_cr("lua vim.lsp.buf.hover()"):with_noremap():with_silent():with_label("Hover Documentation")
    ),
    f = bind.convert_wk_format(
      map_cr("lua vim.lsp.buf.format({async=true})"):with_noremap():with_silent():with_label("Code Formatting")
    ),
    a = bind.convert_wk_format(
      map_cr("lua vim.lsp.buf.code_action()"):with_noremap():with_silent():with_label("Code Action")
    ),
    n = bind.convert_wk_format(
      map_cr("lua require('rename').rename()"):with_noremap():with_silent():with_label("Rename")
    ),
    s = bind.convert_wk_format(
      map_cr("lua vim.lsp.buf.signature_help()"):with_noremap():with_silent():with_label("Signature Help")
    ),
  },

  ["]d"] = bind.convert_wk_format(
    map_cr("lua vim.diagnostic.goto_next()"):with_noremap():with_silent():with_label("Go To Next Diagnostic")
  ),
  ["[d"] = bind.convert_wk_format(
    map_cr("lua vim.diagnostic.goto_prev()"):with_noremap():with_silent():with_label("Go To Previous Diagnostic")
  ),

  ["<leader>v"] = {
    name = "Symbols-Outline",
    v = bind.convert_wk_format(
      map_cr('lua ensure_require"symbols-outline".toggle_outline()')
        :with_noremap()
        :with_silent()
        :with_label("Symbols And Function Preview")
    ),
  },

  ["<leader>g"] = {
    name = "Git",
    j = bind.convert_wk_format(map_cu("Gitsigns next_hunk"):with_noremap():with_silent():with_label("Next Hunk")),
    k = bind.convert_wk_format(map_cu("Gitsigns prev_hunk"):with_noremap():with_silent():with_label("Previous Hunk")),
  },

  ["<leader>p"] = {
    name = "Packer Manage",
    u = bind.convert_wk_format(
      map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait():with_label("Packer Update")
    ),
    c = bind.convert_wk_format(
      map_cr("PackerCompile"):with_silent():with_noremap():with_nowait():with_label("Packer Compile")
    ),
    x = bind.convert_wk_format(
      map_cr("PackerClean"):with_silent():with_noremap():with_nowait():with_label("Packer Clean")
    ),
  },

  ["<leader>d"] = {
    name = "Show Diagnostics In Buffer Or WorkSpace",
    d = bind.convert_wk_format(
      map_cr("Telescope diagnostics bufnr=0")
        :with_noremap()
        :with_silent()
        :with_label("Show Diagnostics In Current Buffer")
    ),
    e = bind.convert_wk_format(
      map_cr("Telescope diagnostics"):with_noremap():with_silent():with_label("Show Diagnostics In WorkSpace")
    ),
    t = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.diagnostics').toggle_virtual_text()")
        :with_noremap()
        :with_silent()
        :with_label("Toggle Diagnostics Virtual Text")
    ),
  },

  ["<leader>m"] = {
    name = "MarkdownPreview, EasyAlign",
    w = bind.convert_wk_format(
      map_cr("MarkdownPreviewToggle"):with_noremap():with_silent():with_label("Toggle Markdown Preview")
    ),
    a = bind.convert_wk_format(map_cmd("<Plug>(EasyAlign)"):with_label("EasyAlign File")),
  },

  ["f"] = {
    name = "Floaterm",
    t = bind.convert_wk_format(map_cr("FloatermToggle"):with_noremap():with_silent():with_label("Toggle Floaterm")),
    r = bind.convert_wk_format(
      map_cr("FloatermNew --cwd=<root>"):with_noremap():with_silent():with_label("Open Floaterm In Project Rood Dir")
    ),
    v = bind.convert_wk_format(
      map_cr("FloatermNew --cwd=<buffer>"):with_noremap():with_silent():with_label("Open Floaterm In CWD")
    ),
    d = { "Kill All Floaterm In Terminal Mode" },
    k = { "Kill Current Floaterm In Terminal Mode" },
  },

  ["<leader>f"] = {
    name = "Telescope Search",
    f = bind.convert_wk_format(map_cr("Telescope find_files"):with_noremap():with_silent():with_label("Find Files")),
    b = bind.convert_wk_format(
      map_cr("Telescope file_browser"):with_noremap():with_silent():with_label("File Browser")
    ),
    g = bind.convert_wk_format(map_cr("Telescope live_grep"):with_noremap():with_silent():with_label("Live Grep")),
    p = bind.convert_wk_format(map_cr("Telescope projects"):with_noremap():with_silent():with_label("Find Projects")),
    j = bind.convert_wk_format(
      map_cr("Telescope todo-comments todo"):with_noremap():with_silent():with_label("Find Todos")
    ),
    o = bind.convert_wk_format(
      map_cr("Telescope oldfiles"):with_noremap():with_silent():with_label("Find Recent Files")
    ),
    n = bind.convert_wk_format(
      map_cr("Telescope neoclip"):with_noremap():with_silent():with_label("Find Saved Buffer In Clipboard")
    ),
    l = bind.convert_wk_format(
      map_cr("Telescope buffers"):with_noremap():with_silent():with_label("Buffers Navigation")
    ),
  },

  ["<leader>c"] = {
    name = "Comment",
    c = bind.convert_wk_format(
      map_cr('lua require("Comment.api").toggle.linewise.current()')
        :with_noremap()
        :with_silent()
        :with_label("Comment Current Line")
    ),
  },

  ["<leader>s"] = {
    name = "Search Word",
    w = bind.convert_wk_format(
      map_cr("lua ensure_require'hop'.hint_words()"):with_noremap():with_silent():with_label("Search Word")
    ),
    s = bind.convert_wk_format(
      map_cr("lua ensure_require'hop'.hint_char2()"):with_noremap():with_silent():with_label("Search By First 2 Char")
    ),
  },

  ["<leader>n"] = {
    name = "Generate Documentation or Line Number Toggle",
    c = bind.convert_wk_format(
      map_cr("lua require('neogen').generate({type='class'})")
        :with_noremap()
        :with_silent()
        :with_label("Generate Class Documentation")
    ),
    t = bind.convert_wk_format(
      map_cr("lua require('neogen').generate({type='type'})")
        :with_noremap()
        :with_silent()
        :with_label("Generate Type Documentation")
    ),
    f = bind.convert_wk_format(
      map_cr("lua require('neogen').generate({type='func'})")
        :with_noremap()
        :with_silent()
        :with_label("Generate Function Documentation")
    ),
    d = bind.convert_wk_format(
      map_cr("lua require('neogen').generate({type='file'})")
        :with_noremap()
        :with_silent()
        :with_label("Generate File Documentation")
    ),
    u = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.misc').toggle_nu()")
        :with_noremap()
        :with_silent()
        :with_label("Toggle Absolute Line Number")
    ),
    r = bind.convert_wk_format(
      map_cr("lua require('doodleVim.extend.misc').toggle_rnu()")
        :with_noremap()
        :with_silent()
        :with_label("Toggle Relative Line Number")
    ),
  },

  ["<F4>"] = bind.convert_wk_format(
    map_cr("AddHeader<CR>"):with_noremap():with_silent():with_label("Start Or Continue Debug")
  ),

  ["<F7>"] = bind.convert_wk_format(
    map_cr("DapContinue"):with_noremap():with_silent():with_label("Start Or Continue Debug")
  ),
  ["<S-F7>"] = bind.convert_wk_format(
    map_cr("DapTerminate"):with_noremap():with_silent():with_label("Stop Debugging, Shortcut: Shift + F7")
  ),
  ["<F8>"] = bind.convert_wk_format(
    map_cr("lua require('dap').pause()"):with_noremap():with_silent():with_label("Pause Debug")
  ),
  ["<S-F8>"] = bind.convert_wk_format(
    map_cr("lua require('dap').restart()"):with_noremap():with_silent():with_label("Restart Debug")
  ),
  ["<F9>"] = bind.convert_wk_format(
    map_cr("DapToggleBreakpoint"):with_noremap():with_silent():with_label("Toggle Breakpoint")
  ),
  ["<F10>"] = bind.convert_wk_format(map_cr("DapStepOver"):with_noremap():with_silent():with_label("Step Over")),
  ["<F11>"] = bind.convert_wk_format(map_cr("DapStepInto"):with_noremap():with_silent():with_label("Step Into")),
  ["<S-F11>"] = bind.convert_wk_format(
    map_cr("DapStepOut"):with_noremap():with_silent():with_label("Step Out, Shortcut: Shift + F11")
  ),
  ["<F12>"] = bind.convert_wk_format(
    map_cr("lua require('dap').run_to_cursor()"):with_noremap():with_silent():with_label("Run To Cursor")
  ),
  ["<S-F12>"] = bind.convert_wk_format(
    map_cr("lua require('dap').run_last()")
      :with_noremap()
      :with_silent()
      :with_label("Run To Last, Shortcut: Shift + F12")
  ),

  ["<S-h>"] = bind.convert_wk_format(
    map_cr("BufferPrevious"):with_noremap():with_silent():with_label("Previous Buffer")
  ),
  ["<S-l>"] = bind.convert_wk_format(map_cr("BufferNext"):with_noremap():with_silent():with_label("Next Buffer")),

  ["<S-n>"] = bind.convert_wk_format(
    map_cr("lua require('doodleVim.extend.misc').enhanced_buffer_close()")
      :with_noremap()
      :with_silent()
      :with_label("Close Current Buffer")
  ),
  ["<M-s>"] = bind.convert_wk_format(
    map_cr("BufferOrderByDirectory"):with_noremap():with_silent():with_label("Sort Buffer")
  ),
  ["<M-b>"] = bind.convert_wk_format(
    map_cr("BufferCloseBuffersLeft"):with_noremap():with_silent():with_label("Close All Buffers Left")
  ),
  ["<M-m>"] = bind.convert_wk_format(
    map_cr("BufferCloseBuffersRight"):with_noremap():with_silent():with_label("Close All Buffers Right")
  ),
  ["<M-h>"] = bind.convert_wk_format(
    map_cr("BufferMovePrevious"):with_noremap():with_silent():with_label("Re-order To Previous")
  ),
  ["<M-l>"] = bind.convert_wk_format(
    map_cr("BufferMoveNext"):with_noremap():with_silent():with_label("Re-order To Next")
  ),
  ["<M-i>"] = bind.convert_wk_format(map_cr("BufferPin"):with_noremap():with_silent():with_label("Pin Buffer")),
  ["<M-o>"] = bind.convert_wk_format(map_cr("BufferPick"):with_noremap():with_silent():with_label("Pick Buffer")),

  ["<C-Space>"] = bind.convert_wk_format(
    map_cr("lua require('doodleVim.extend.misc').toggle_whichkey()")
      :with_noremap()
      :with_silent()
      :with_label("Show Keymaps")
  ),
  ["<M-n>"] = bind.convert_wk_format(map_cr("Gitsigns next_hunk"):with_noremap():with_silent():with_label("Next Hunk")),
  ["<M-p>"] = bind.convert_wk_format(
    map_cr("Gitsigns prev_hunk"):with_noremap():with_silent():with_label("Previous Hunk")
  ),
}

plug_map.visual = {
  ["g"] = {
    name = "Lsp Function",
    f = bind.convert_wk_format(
      map_cu("lua vim.lsp.buf.formatting()")
        :with_noremap()
        :with_silent()
        :with_label("Selected Code Formatting")
        :with_mode("v")
    ),
    a = bind.convert_wk_format(
      map_cu("lua vim.lsp.buf.range_code_action()")
        :with_noremap()
        :with_silent()
        :with_label("Range Code Action")
        :with_mode("v")
    ),
    n = bind.convert_wk_format(
      map_cr("lua require('rename').rename()"):with_noremap():with_silent():with_label("Rename"):with_mode("v")
    ),
  },

  ["<leader>m"] = {
    name = "MarkdownPreview, EasyAlign",
    a = bind.convert_wk_format(map_cmd("<Plug>(EasyAlign)"):with_label("EasyAlign Selected Buffer"):with_mode("v")),
  },

  ["t"] = {
    name = "Tree,Translate",
    r = bind.convert_wk_format(
      map_cu("TranslateW"):with_silent():with_label("Translate Selected Buffer"):with_mode("v")
    ),
  },

  ["<leader>c"] = {
    name = "Comment",
    c = bind.convert_wk_format(
      map_cmd('<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
        :with_noremap()
        :with_silent()
        :with_label("Comment Selected Line")
        :with_mode("x")
    ),
    v = bind.convert_wk_format(
      map_cmd('<ESC><CMD>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>')
        :with_noremap()
        :with_silent()
        :with_label("Comment Selected Line")
        :with_mode("x")
    ),
  },

  ["<leader>l"] = {
    name = "Draw Ascii Picture",
    l = bind.convert_wk_format(map_cu("VBox"):with_noremap():with_silent():with_label("Normal Line"):with_mode("v")),
    d = bind.convert_wk_format(map_cu("VBoxD"):with_noremap():with_silent():with_label("Double Line"):with_mode("v")),
    h = bind.convert_wk_format(map_cu("VBoxH"):with_noremap():with_silent():with_label("Hard Line"):with_mode("v")),
    f = bind.convert_wk_format(map_cu("VFill"):with_noremap():with_silent():with_label("Fill Box"):with_mode("v")),
  },

  ["<C-Space>"] = bind.convert_wk_format(
    map_cmd("<Cmd>lua require('doodleVim.extend.misc').toggle_whichkey()<CR>")
      :with_noremap()
      :with_label("Show Keymaps")
      :with_mode("v")
  ),
}

plug_map.insert = {
  ["<C-Space>"] = bind.convert_wk_format(
    map_cmd("<Cmd>lua require('doodleVim.extend.misc').toggle_whichkey()<CR>")
      :with_noremap()
      :with_label("Show Keymaps")
      :with_mode("i")
  ),
}

return plug_map
