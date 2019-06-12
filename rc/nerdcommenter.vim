" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
          \ 'javascript': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' },
          \ 'less': { 'left': '/*', 'right': '*/' }
      \ }

let g:NERDAltDelims_javascript = 1
let g:NERDDefaultNesting = 1
