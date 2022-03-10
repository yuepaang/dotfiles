local eslint = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'},
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true
}

local clang_format = {
    formatCommand = 'clang-format -style=LLVM ${INPUT}',
    formatStdin = true
}
local prettier = {
    formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
    formatStdin = true
}
local stylua = {
    formatCommand = 'stylua -s -',
    formatStdin = true
}
local black = {
    formatCommand = 'black --fast -',
    formatStdin = true
}

local flake8 = {
    lintCommand = "flake8 --max-line-length 160 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f:%l:%c: %t%n%n%n %m"},
    lintSource = "flake8"
}

local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true
}

local shellcheck = {
    lintCommand = "shellcheck -f gcc -x -",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m"},
    lintSource = "shellcheck"
}

return {
    -- cpp = { clang_format },
    css = {prettier},
    html = {prettier},
    javascript = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    json = {prettier},
    lua = {stylua},
    markdown = {prettier},
    python = {black, isort, flake8},
    scss = {prettier},
    typescript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    yaml = {prettier},
    bash = {shellcheck}
}
