call plug#begin()

Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tidalcycles/vim-tidal'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'Chiel92/vim-autoformat'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'itchyny/lightline.vim'
Plug 'unblevable/quick-scope'

" Color schemes
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

call plug#end()

"""""""""""""""""""""""""""""""
" Window movement
"""""""""""""""""""""""""""""""

inoremap <C-J> <C-W><C-J>
inoremap <C-K> <C-W><C-K>
inoremap <C-L> <C-W><C-L>
inoremap <C-H> <C-W><C-H> 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader="."

" disable annoying conceal from indentLine
let g:indentLine_setConceal = 0
let conceallevel=0

" Escape in terminal mode
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :sp term://zsh<cr>
nnoremap <leader>vt :vspl term://zsh<cr>

" set cindent
set autoindent
set noexpandtab
set shiftwidth=4
set incsearch
set mouse=a
set tabstop=4

syntax enable
syntax on
filetype plugin indent on
set nocompatible " be iMproved, required
filetype off " required

filetype plugin on

let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}

"""""""""""""""""""""""""""""""
" Lightline
"""""""""""""""""""""""""""""""
function! LSPStatus() abort
	let l:diagnosticsDict = LanguageClient#statusLineDiagnosticsCounts()
	let l:errors = get(l:diagnosticsDict,'E',0)
	let l:warnings = get(l:diagnosticsDict,'W',0)
	let l:informations = get(l:diagnosticsDict,'I',0)
	let l:hints = get(l:diagnosticsDict,'H',0)
	return l:errors + l:warnings + l:informations + l:hints == 0 ? "✔ " : "E:" . l:errors . " " . "W :" . l:warnings . "I:" . l:informations . " " . "H:" . l:hints
endfunction

""""""""""""""""""""""""""""""
" Markdown
"""""""""""""""""""""""""""""""

" Spell checking
autocmd BufRead,BufNewFile *.md setlocal spell

au filetype markdown nnoremap <F1> z=

" Set spell language to English
au filetype markdown nnoremap <leader>se :setlocal spell spelllang=en<CR>

" Set spell language to English
au filetype markdown nnoremap <leader>su :setlocal spell spelllang=en<CR>

" To html
au filetype markdown nnoremap <leader>th :! pandoc -s -o %:r.html %<CR>

" To pdf
au filetype markdown nnoremap <leader>tb cs__<CR>

" Headerss
au filetype markdown nnoremap <leader>h1 _i# <esc>
au filetype markdown nnoremap <leader>h2 _i## <esc>
au filetype markdown nnoremap <leader>h3 _i### <esc>
au filetype markdown nnoremap <leader>h4 _i#### <esc>
au filetype markdown nnoremap <leader>h5 _i##### <esc>
au filetype markdown nnoremap <leader>h6 _i###### <esc>

" Open terminal
au filetype markdown nnoremap <leader>t :tabnew term://zsh<CR>

"""""""""""""""""""""""""""""""
" Word count
"""""""""""""""""""""""""""""""
" Notes
let g:notes_directories = ['/home/mads/Dropbox/vimnotes/']
let g:notes_conceal_code = 0

"""""""""""""""""""""""""""""""
" Pandoc
"""""""""""""""""""""""""""""""
function! g:MDtoPDF()
    let l:fn_minus_suffix=expand('%:r')
    let l:fn_out=fn_minus_suffix . '.pdf' 

    execute '! pandoc % -o ' . fn_out
endfunction

" au filetype markdown nnoremap <F5> :execute MDtoPDF()<CR>
au filetype markdown nnoremap <F6> :execute '! open %:r.pdf'<CR>

au filetype markdown nnoremap <c-e> :execute MDtoPDF()<CR>
au filetype markdown nnoremap <leader>o :execute '! open %:r.pdf'<CR>


"""""""""""""""""""""""""""""""
" GENERAL REMAPPINGS
"""""""""""""""""""""""""""""""
" Reload vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>

" Open tmux config file in new tab
nnoremap <leader>at :tabnew ~/.tmux.conf<CR>

" open .vimrc in a new tab
noremap <leader>av :tabnew $MYVIMRC<CR>

" open .bash_profile in a new tab
nnoremap <leader>ab :tabnew ~/.bash_profile<CR>

" Reload bash_profile
nnoremap <leader>rb :! source ~/.bash_profile<CR>

" Find and delete next whitespace
nnoremap d<space> /\s<cr>x
nnoremap f<space> /\s<cr>

"""""""""""""""""""""""""""""""
" Tabularize
"""""""""""""""""""""""""""""""

" =
nmap <leader>t= :Tab /=<CR>
vmap <leader>t= :Tab /=<CR>

" :
nmap <leader>t: :Tab /:\zs<CR>
vmap <leader>t: :Tab /:\zs<CR>

"""""""""""""""""""""""""""""""
" SuperCollider stuff
"""""""""""""""""""""""""""""""
" wrap supercollider post window
autocmd FileType scnvim setlocal wrap

" scnvim neovim docs !
let g:scnvim_scdoc = 1

" vertical 'v' or horizontal 'h' split
let g:scnvim_postwin_orientation = 'v'

" position of the post window 'right' or 'left'
let g:scnvim_postwin_direction = 'right'

" default is half the terminal size for vertical and a third for horizontal
let g:scnvim_postwin_size = 50

" automatically open post window on a SuperCollider error
let g:scnvim_postwin_auto_toggle = 1

" duration of the highlight
let g:scnvim_eval_flash_duration = 100

" number of flashes. A value of 0 disables this feature.
let g:scnvim_eval_flash_repeats = 5

" set this variable if you don't want the "echo args" feature
let g:scnvim_echo_args = 1

" configure the color
highlight SCNvimEval guifg=black guibg=white ctermfg=black ctermbg=white

" create a custom status line for supercollider buffers
function! s:set_sclang_statusline()
    setlocal stl=
    setlocal stl+=%f
    setlocal stl+=%=
    setlocal stl+=%(%l,%c%)
    setlocal stl+=\ \|
    setlocal stl+=%18.18{scnvim#statusline#server_status()}
endfunction

augroup scnvim_stl
  autocmd!
  autocmd FileType supercollider call <SID>set_sclang_statusline()
augroup END
"
" Mappings

" Start SCNvim
au filetype supercollider nnoremap <F1> :SCNvimStart<CR>

" SCNvim Statusline
au filetype supercollider nnoremap <F2> :SCNvimStatusLine<CR>

" SCNvim tags recompile
au filetype supercollider nnoremap <F3> :SCNvimTags<CR>

" Clear post window
au filetype supercollider nmap <F4> <Plug>(scnvim-postwindow-clear)

" Hard stop
au filetype supercollider nmap <F12> <Plug>(scnvim-hard-stop)

" Echo args
au filetype supercollider nnoremap <buffer>; :call scnvim#util#echo_args()<CR>

" Recompile<CR>
au filetype supercollider nnoremap <leader>sk :SCNvimRecompile<CR>

" Regenerate Ctags
au filetype supercollider nnoremap <buffer> <leader>rt :SCNvimTags<CR>

" Boot server
au filetype supercollider nnoremap <buffer> <leader>b :call scnvim#sclang#send_silent('Server.local.boot')<CR>

" Look up implementation for class under cursor
au filetype supercollider nnoremap <buffer> <leader>si g]

au filetype supercollider nnoremap <buffer> <leader>rt :SCNvimTags<CR>

" Statusline
au fileType supercollider call <SID>set_sclang_statusline()

""""""""""""""""""""""""""""""
"  Colors
"""""""""""""""""""""""""""""""
let base16colorspace=256  " Access colors present in 256 colorspace
" let g:base16_shell_path=base16-builder/output/shell/

" enable true color for nvim
if has('nvim')
    set inccommand=nosplit " preview changes (:s/) incrementally
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
    " put all swap files in one place
    " neovim already does this by default, ~/.local/share/nvim/swap
    set directory^=$HOME/.vim/.swap//
    set ttyfast " assume fast terminal connection
endif

set background=dark
set t_Co=256
colorscheme iceberg

" Echo the highlighting group (for color schemes) under hte cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

""""""""""""""""""""""""""""""
" Ignore
"""""""""""""""""""""""""""""""
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildignore+=*.jpg,*.png,*.gif,*.bmp,*.a,*.o,*.tiff,*.nef
set wildignore+=*.mp4,*.mkv,*.avi,*.srt

"""""""""""""""""""""""""""""""
" Performance
"""""""""""""""""""""""""""""""

" avoid menu.vim (saves ~100ms)
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1

"""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""
" if has('folding')
"   if has('windows')
"     let &fillchars='vert: '           " less cluttered vertical window separators
"   endif
"   set foldmethod=indent               " not as cool as syntax, but faster
"   set foldlevelstart=99               " start unfolded
" endif

augroup myformatting
    autocmd!
    " autocmd filetype markdown InsertLeave * normal gwap<CR>
    " autocmd filetype markdown BufWrite * normal gwap<CR>
augroup END

"""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""

" Python3
let g:pymode_python = 'python3'

" Run file Python
let g:pymode_run_bind = '<C-e>'

" Docs open Python
let g:pymode_rope_show_doc_bind = '<S-k>'
let g:python3_host_prog='/usr/bin/python3'

" Automatic Lint before writing buffer to file
au BufWritePre *.py :PymodeLintAuto

" Google calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
let g:calendar_event_start_time=1

" Sessions
let g:session_autosave = 'yes'
let g:session_default_to_last = 0
let g:session_autoload = 'no'
nnoremap <leader>o :OpenSession<CR>
" conceallevel
au BufWinEnter *.md set concealcursor-=n

" Tidal defaults
" let g:tidal_default_config = {"socket_name": "default", "target_pane": "1.2"}

" Use NeoVim terminal
let g:tidal_target = "terminal"

" Ubuntu
map ½ $
" vnoremap ½ $

let g:notes_tab_indents = 0

" colorizer
" lua require'colorizer'.setup()

" fzf
nnoremap <C-p> :FZF<CR>

" distraction free writing
nnoremap <C-g> :Goyo<CR>

" Goyo in markdown
" au BufWinEnter *.md :exec 'Goyo'
"

" Processing
au filetype pde nnoremap <leader>m :make<cr>

" Disable line wrapping in Markdown
au BufWinEnter *.md set wrap
au BufWinEnter *.md set linebreak
au BufWinEnter *.md set nolist  " list disables linebreak
au BufWinEnter *.md set textwidth=0  " list disables linebreak

"""""""""""""""""""""""""""""""""""""
" YouCompleteMe, UltiSnips and cpp
"""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/global_extra_conf.py'

" Better diagnostics
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_show_diagnostics_ui = 1

" openframeworks + vim http://brendandawes.com/blog/vim-of
autocmd  BufRead,BufNewFile  *.cpp let &makeprg = 'if [ -f Makefile ]; then make Release && make RunRelease; else make Release -C .. && make RunRelease -C ..; fi'

" Code formatting
autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format

let g:ycm_clangd_binary_path = "/usr/bin/clangd"


" YCM KEYBINDINGS
function! YcmStuff() 
    nnoremap si :YcmCompleter GoToDefinition<cr>
    nnoremap sk :YcmRestartServer<cr>
    nnoremap <F1> :YcmCompleter FixIt<cr>
    nnoremap K :YcmCompleter GetDoc<cr>
    nnoremap ; :YcmCompleter GetType<cr>
endfunction

augroup c
    autocmd!
	autocmd FileType c,cpp,h,hpp,glsl nnoremap <F2> :!compiledb -n make<cr>
    autocmd FileType c,cpp,h,hpp,glsl call SetMake()
    autocmd FileType c,cpp,h,hpp,glsl call YcmStuff()
augroup end


" Flak tricks for scnvim like experience
augroup c
    autocmd!
    autocmd FileType c,cpp,h,hpp,glsl call MakeRun()
augroup end

function! MakeRun()
    nnoremap <C-e> :terminal make -j8 && make run<cr>
    inoremap <C-e> <esc>:terminal make -j8 && make run && exit<cr>
endfunction

" new split with alternate file  
nnoremap mv :AV<cr>
" switch in same window
nnoremap ma :A<cr>

" YouCompleteMe and UltiSnips compatibility.
let g:ycm_use_ultisnips_completer = 1

" make YCM compatible with UltiSnips (using supertab)
" from: https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Expand snippets from UltiSnips with tab
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']

" Additional UltiSnips config.
" let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

" Disable unhelpful semantic completions.
let g:ycm_filetype_specific_completion_to_disable = {
			\   'markdown': 1,
			\   'supercollider': 1,
			\   'gitcommit': 1,
			\ }

let g:ycm_filetype_blacklist = {
			\ 'supercollider': 1,
			\ 'markdown': 1,
			\ 'text': 1,
			\ 'notes': 1,
			\ 'mail': 1
			\ }


" LanguageClient
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_hoverPreview = 'Auto'
" let g:LanguageClient_preferredMarkupKind = ['plaintext', 'markdown']
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

let $RUST_BACKTRACE = 1
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_virtualTextPrefix = ''
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

let g:LanguageClient_useVirtualText = "No"

"""""""""""""""""""""""""""""""""""""
" RUST
"
" rust requirements
" rustup component add rls
" rustup component add rustfmt
" rustup component add clippy
"
" Note: Most of YCM's rust capabilities are disabled by default and must be
" enabled in the global_extra_conf.py file
"""""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1

au FileType rust nnoremap <F1> :call LanguageClient#textDocument_hover()<CR>

function! Rusty()
    nnoremap <C-e> :terminal cargo run<cr>
    inoremap <C-e> <esc>:terminal cargo run<cr>

	" LanguageClient
	nnoremap <F5> :call LanguageClient_contextMenu()<CR>	

	" Get nice info on thing under cursor
	nnoremap K :call LanguageClient#textDocument_hover()<CR>

	" Where is thing under cursor defined?
    nnoremap <silent> <leader>si :call LanguageClient#textDocument_definition()<CR>
	
	" Where is thing under cursor used?
	nnoremap <silent> <leader>sl :call LanguageClient#textDocument_references()<CR>

    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

	" Open local rust documentation in browser
	" nnoremap <leader>K :! cargo doc --open<cr>	
endfunction 

augroup rust
    autocmd!
    autocmd FileType rust call Rusty()
	" autocmd FileType rust call YcmStuff()
augroup end

"""""""""""""""""""""""""""""""
" Arduino / Teensy
"""""""""""""""""""""""""""""""
nnoremap <buffer> <leader>am :ArduinoVerify<CR>
autocmd BufNewFile,BufRead *.ino nnoremap <C-e> :ArduinoUpload<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>
