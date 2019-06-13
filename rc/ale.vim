let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

let g:ale_linters = {
            \       'c': ['cppcheck', 'flawfinder'],
            \       'cpp': ['cppcheck', 'flawfinder'],
            \       'css': ['stylelint'],
            \       'html': ['tidy'],
            \       'json': [],
            \       'markdown': ['languagetool'],
            \       'python': ['autopep8', 'flake8', 'mypy', 'pydocstyle'],
            \       'rust': ['cargo'],
            \       'sh': ['shellcheck'],
            \       'text': ['languagetool'],
            \       'vim': ['vint'],
            \       'go': ['gopls'],
            \}

"查看上一个错误
nnoremap <silent> [a :ALEPrevious<CR>
"查看下一个错误
nnoremap <silent> ]a :ALENext<CR>
"自定义error和warning图标
let g:ale_sign_error = "\uf65b"
let g:ale_sign_warning = "\uf421"

"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 光标移动到错误的地方时立即显示错误
let g:ale_echo_delay = 0
