{ pkgs, lib, config, ... }:

{
  # Colorschemes I can't live without
  # Maybe at some point want to symlink ~/.vim instead but for now its left as it is.
  home.file.".vim/colors".source =
    config.lib.file.mkOutOfStoreSymlink ./vim/colors;

  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.dracula-vim
      pkgs.vimPlugins.vim-nix
    ];
    extraConfig =  ''
      if &compatible
        set nocompatible
      endif
      color relaxedgreen
      function! SaveIfUnsaved()
        if &modified
          :silent! w
        endif
      endfunction
      cmap w!! %!sudo tee > /dev/null %
      set formatoptions-=o
      au FocusLost,BufLeave * :call SaveIfUnsaved()
      au FocusGained,BufEnter * :silent! !
      set whichwrap=<,>,[,],b,
      set backspace=indent,eol,start
      set ruler
      set cursorline
      set cursorcolumn
      set autoread
      let mapleader = " "
      let g:mapleader = " "
      nmap <leader>w :w!<cr>
      noremap <leader>u :w \| startinsert \| term urlview %<CR>
      map <leader>c 0i# <ESC>
      nnoremap ; :
      nnoremap k gk
      nnoremap j gj
      nnoremap <Up> gk
      nnoremap <Down> gj
      nnoremap <Tab> %
      vnoremap <Tab> %
      nnoremap <A-h> <C-w>h
      nnoremap <A-j> <C-w>j
      nnoremap <A-k> <C-w>k
      nnoremap <A-l> <C-w>l
      nnoremap K <nop>
      nnoremap q :q
      nnoremap qq :q!<CR>
      nnoremap Q q
      inoremap # #
      au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
      au BufNewFile,BufRead /dev/shm/pass.* setlocal noswapfile nobackup noundofile
      set laststatus=2
      filetype plugin indent on
      if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        endif
      syntax on
      set nobackup
      set noswapfile
      highlight Comment cterm=italic
      set list
      set listchars=tab:>-,trail:~,extends:>,precedes:<
      set wildmenu
      set wildignore=*.o,*~,*.pyc
      :highlight ExtraWhitespace ctermbg=red guibg=red
      :match ExtraWhitespace /\s\+$/
      :match ExtraWhitespace /\s\+$\| \+\ze\t/
      func! DeleteTrailingWS()
        exe "normal mz"
        %s/\s\+$//ge
        exe "normal `z"
      endfunc
      autocmd BufWrite *.py :call DeleteTrailingWS()
      func! GitBranch()
        return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
      endfunc
      func! GitStatus()
        let l:branchname = GitBranch()
        return strlen(l:branchname) > 0?' '.l:branchname.' ':""
      endfunc
      set statusline=%F%m%r%h%w\ \ \ \ [%Y]\ \ \ \ [%03l:%03v]\ \ \ \ [%p%%]\ \ \ \ [%L]\ \ \ \[%{&ff}]
      "set statusline+=%#PmenuSel#
      "set statusline+=%{GitStatus()}
      "set statusline+=%#LineNr#
      '';
    settings = {
      background = "light";
      copyindent = true;
      expandtab = true;
      hidden = true;
      history = 7000;
      ignorecase = true;
      modeline = true;
      mouse = "n";
      mousefocus = true;
      mousehide = true;
      mousemodel = "extend";
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      smartcase = true;
      tabstop = 4;
      undodir = ["~/.vim/undodir//"];
      undofile = true;
    };
  };
}
