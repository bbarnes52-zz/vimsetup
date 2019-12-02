call plug#begin()
Plug 'cappyzawa/starlark.vim'
Plug 'fatih/vim-go'
" Support for nova color scheme.
Plug 'trevordmiller/nova-vim'
" Automatically adds closing parentheses, quotes, etc.
Plug 'jiangmiao/auto-pairs'
call plug#end()

" Search down into subfolders.
" Provides auto-completion for all file-related tasks.
set path+=**

" Display all matching files when we tab complete.
set wildmenu

"""____________GO SETTINGS_____________"""

" Save file automatically when running GoBuild (and more generally, :make).
set autowrite

" Only use quickfix menu, not location list.
let g:go_list_type = "quickfix"

" Map go-build and go-test to easy to type shortcuts.
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)

" Shortcut for GoAlternate.
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')

" Automatically display GoInfo.
let g:go_auto_type_info = 1
" Automatically highlight all instances of a variable.
let g:go_auto_sameids = 1

" Run go-fmt on save.
let g:go_fmt_autosave = 1

" ==== COLORS ====

set background=light
syntax on
colorscheme nova
let g:nova_transparent = 1

" ==== MISC ====

" Enables loading plugin files for specific file types.
filetype plugin on

" Display line numbers in gutter.
set number

" Display the full file path
set laststatus=2

" Enable mouse.
set mouse=a

" Highlight all search pattern matches.
set hlsearch

" Don’t update screen during macro and script execution.
set lazyredraw

" Wrap long lines to fit in the window.
set wrap
" Don't linebreak in the middle of a word.
set linebreak
" Don't know what this one does.
set nolist

" ==== CURSOR ====

" Highlight cursor line.
set cursorline

" Display line / column number of cursor.
set ruler

" ==== TABS ====

" Defaults.
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

filetype plugin indent on

" 4 spaces.
au FileType python     setlocal ts=4 sts=4 sw=4 et
au FileType javascript setlocal ts=4 sts=4 sw=4 et

" 2 spaces.
au FileType html       setlocal ts=2 sts=2 sw=2 et
au FileType yaml       setlocal ts=2 sts=2 sw=2 et
au FileType bash       setlocal ts=2 sts=2 sw=2 et

" ==== COMPLETION ====

let g:deoplete#enable_at_startup = 1

" Completion window in insert mode.
set completeopt-=preview

" Smart tab completion. See https://vim.fandom.com/wiki/Smart_mapping_for_tab_completion.
function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" ==== GO ====

" Speed up vim-go. No need to highlight everything.
let g:go_highlight_build_constraints = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_fields = 0
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_operators = 0
let g:go_highlight_structs = 0
let g:go_highlight_types = 0

" ==== MACROS ====
            
set backspace=indent,eol,start

let mapleader=","

" Previous buffer.
nnoremap <leader>l :e #<enter>

" Search and replace hovered word.
nnoremap <leader>s :.,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" Search and replace highlighted text.
xnoremap <leader>s y:.,$s/<c-r>"//gc<left><left><left>

" Unhighlight.
nnoremap <leader>n :noh<enter>

" For shitty typists.
nmap ; :

" Keep search results centered.
nnoremap n nzz
nnoremap N Nzz

" Go macros.
au FileType go nmap <leader>i :GoImports<enter>
au FileType go nmap <leader>f :GoFmt<enter>
au FileType go nmap <leader>b :GoBuild<enter>
au FileType go nmap <leader>d :GoDef<enter>
au FileType go nmap <leader>e :GoTest<enter>

" Zooms current window. Exit it with :wq
nnoremap <leader>z :tabnew %<enter>

" Don't use monorepo Go wrapper.
let $USE_SYSTEM_GO=1
