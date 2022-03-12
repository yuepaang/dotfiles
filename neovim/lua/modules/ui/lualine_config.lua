local lualine = require("lualine")
local auto_theme = require("lualine.themes.auto")

local gps = require("nvim-gps")

local function window()
    return vim.api.nvim_win_get_number(0)
end

-- Color table for highlights
-- stylua: ignore
local colors = {
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67'
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local function separator()
    return "%="
end

local function lsp_client(msg)
    msg = msg or ""
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
            return ""
        end
        return msg
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end
    -- add formatter
    local formatters = require("config.lsp.null-ls.formatters")
    local supported_formatters = formatters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_formatters)

    -- add linter
    local linters = require("config.lsp.null-ls.linters")
    local supported_linters = linters.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_linters)

    -- add hover
    local hovers = require("config.lsp.null-ls.hovers")
    local supported_hovers = hovers.list_registered(buf_ft)
    vim.list_extend(buf_client_names, supported_hovers)

    return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

-- New Config from cosmos
local config = {
    options = {
        icons_enabled = true,
        theme = auto_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = " ", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        -- lualine_a = {
        --     {
        --         window,
        --         separator = {
        --             left = "",
        --             right = "",
        --         },
        --         right_padding = 2,
        --     },
        -- },
        lualine_a = { "mode" },
        -- lualine_b = { "mode", "branch", "diff", "diagnostics", "filename" },
        lualine_b = {
            "branch",
            "diff",
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                colored = false,
            },
        },
        -- lualine_c = {},
        lualine_c = {
            { separator },
            { lsp_client, icon = " ", color = { fg = colors.violet, gui = "bold" } },
            -- { lsp_progress },
            {
                gps.get_location,
                cond = gps.is_available,
                color = { fg = colors.green },
            },
        },
        -- lualine_x = {},
        lualine_x = { "filename", "encoding", "fileformat", "filetype" },
        -- lualine_y = { "encoding", "fileformat", "filetype", "progress" },
        lualine_y = { "progress" },
        lualine_z = {
            {
                "location",
                -- separator = {
                --     left = "",
                --     right = "",
                -- },
                -- left_padding = 2,
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {
            -- {
            --     window,
            --     separator = {
            --         left = "",
            --         right = "",
            --     },
            --     right_padding = 2,
            -- },
        },
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {
            {
                -- "location",
                -- separator = {
                --     left = "",
                --     right = "",
                -- },
                -- left_padding = 2,
            },
        },
        lualine_z = {},
    },
    tabline = {},
    extensions = { "nvim-tree" },
}

-- Config FLZ
-- local config = {
--     options = {
--         -- Disable sections and component separators
--         component_separators = '',
--         section_separators = '',
--         theme = {
--             -- We are going to use lualine_c an lualine_x as left and
--             -- right section. Both are highlighted by c theme .  So we
--             -- are just setting default looks o statusline
--             normal = {
--                 -- a = { fg = colors.fg, bg = colors.bg },
--                 -- b = { fg = colors.fg, bg = colors.bg },
--                 c = {
--                     fg = colors.fg,
--                     bg = colors.bg
--                 }
--             },
--             inactive = {
--                 x = {
--                     fg = colors.fg,
--                     bg = colors.bg
--                 }
--                 -- y = { fg = colors.fg, bg = colors.bg },
--                 -- z = { fg = colors.fg, bg = colors.bg },
--             }
--         },
--         always_divide_middle = true
--     },
--     sections = {
--         -- these are to remove the defaults
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = {},
--         lualine_x = {},
--         lualine_y = {},
--         lualine_z = {}
--     },
--     inactive_sections = {
--         -- these are to remove the defaults
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = {},
--         lualine_x = {},
--         lualine_y = {},
--         lualine_z = {}
--     },
--     extensions = {'nvim-tree'}
-- }

-- local function ins(section, component)
--     table.insert(section, component)
-- end

-- -- Inserts a component in lualine_c at left section
-- local function ins_a(component)
--     ins(config.sections.lualine_a, component)
-- end

-- local function ins_b(component)
--     ins(config.sections.lualine_b, component)
-- end

-- local function ins_c(component)
--     ins(config.sections.lualine_c, component)
-- end

-- -- Inserts a component in lualine_x ot right section
-- local function ins_x(component)
--     ins(config.sections.lualine_x, component)
-- end

-- local function ins_y(component)
--     ins(config.sections.lualine_y, component)
-- end

-- local function ins_z(component)
--     ins(config.sections.lualine_z, component)
-- end

-- ins_c {
--     -- mode component
--     function()
--         -- auto change color according to neovims mode
--         local mode_color = {
--             n = colors.red,
--             i = colors.green,
--             v = colors.blue,
--             [''] = colors.blue,
--             V = colors.blue,
--             c = colors.magenta,
--             no = colors.red,
--             s = colors.orange,
--             S = colors.orange,
--             [''] = colors.orange,
--             ic = colors.yellow,
--             R = colors.violet,
--             Rv = colors.violet,
--             cv = colors.red,
--             ce = colors.red,
--             r = colors.cyan,
--             rm = colors.cyan,
--             ['r?'] = colors.cyan,
--             ['!'] = colors.red,
--             t = colors.red
--         }
--         vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
--         return ''
--     end,
--     color = 'LualineMode',
--     padding = {
--         left = 0,
--         right = 1
--     }
-- }

-- ins_c {
--     'filename',
--     file_status = false,
--     cond = conditions.buffer_not_empty,
--     color = {
--         fg = colors.green,
--         gui = 'bold'
--     },
--     padding = {
--         left = 1,
--         right = 1
--     },
--     separator = "┃"
-- }

-- ins_c {
--     'diagnostics',
--     sources = {'nvim_lsp'},
--     symbols = {
--         error = ' ',
--         warn = ' ',
--         info = ' '
--     },
--     diagnostics_color = {
--         color_error = {
--             fg = colors.red
--         },
--         color_warn = {
--             fg = colors.yellow
--         },
--         color_info = {
--             fg = colors.cyan
--         }
--     },
--     separator = "┃"
-- }

-- ins_x {
--     'location',
--     padding = {
--         left = 0,
--         right = 0
--     },
--     color = {
--         fg = colors.fg,
--         gui = 'bold'
--     },
--     separator = "-"
-- }

-- ins_x {
--     'progress',
--     padding = {
--         left = 0,
--         right = 1
--     },
--     color = {
--         fg = colors.fg,
--         gui = 'bold'
--     },
--     separator = "-"
-- }

-- ins_x {
--     'filesize',
--     cond = conditions.buffer_not_empty,
--     padding = {
--         left = 1,
--         right = 1
--     },
--     color = {
--         fg = colors.fg,
--         gui = 'bold'
--     },
--     separator = "┃"
-- }

-- -- Add components to right sections
-- ins_x {
--     'o:encoding', -- option component same as &encoding in viml
--     fmt = string.upper, -- I'm not sure why it's upper case either ;)
--     cond = conditions.hide_in_width,
--     color = {
--         fg = colors.green,
--         gui = 'bold'
--     },
--     padding = {
--         left = 1,
--         right = 0
--     }
-- }

-- ins_x {
--     'fileformat',
--     fmt = string.upper,
--     icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--     color = {
--         fg = colors.green,
--         gui = 'bold'
--     },
--     padding = {
--         left = 1,
--         right = 1
--     },
--     separator = "┃"
-- }

-- ins_x {
--     'branch',
--     icon = '',
--     color = {
--         fg = colors.violet,
--         gui = 'bold'
--     },
--     padding = {
--         left = 1,
--         right = 0
--     }
-- }

-- ins_x {
--     'diff',
--     -- Is it me or the symbol for modified us really weird
--     symbols = {
--         added = ' ',
--         modified = '柳',
--         removed = ' '
--     },
--     diff_color = {
--         added = {
--             fg = colors.green
--         },
--         modified = {
--             fg = colors.orange
--         },
--         removed = {
--             fg = colors.red
--         }
--     },
--     cond = conditions.hide_in_width
-- }

-- Now don't forget to initialize lualine
lualine.setup(config)
