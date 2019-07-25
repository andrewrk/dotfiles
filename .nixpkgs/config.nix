pkgs : {
  allowUnfree = true;
  packageOverrides = pkgs : with pkgs; rec {
    my_vim = vim_configurable.customize {
      name = "vim";

      vimrcConfig.customRC = ''
        syntax on
        filetype on
        set expandtab
        set bs=2
        set tabstop=2
        set shiftwidth=2
        set autoindent
        set smartindent
        set smartcase
        set ignorecase
        set modeline
        set nocompatible
        set encoding=utf-8
        set hlsearch
        set history=700
        set t_Co=256
        set tabpagemax=1000
        set ruler
        set nojoinspaces
        set shiftround

        set nolbr
        set tw=0

        " Visual mode pressing * or # searches for the current selection
        " Super useful! From an idea by Michael Naumann
        vnoremap <silent> * :call VisualSelection('f')<CR>
        vnoremap <silent> # :call VisualSelection('b')<CR>

        let mapleader = ","

        " Disable highlight when <leader><cr> is pressed
        map <silent> <leader><cr> :noh<cr>

        " Smart way to move between windows
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

        " I accidentally hit F1 all the time
        imap <F1> <Esc>

        " nice try, Ex mode
        map Q <Nop>
        " who uses semicolon anyway?
        map ; :

        " ==== custom macros ====
        " Delete a function call. example:  floor(int(var))
        "         press when your cursor is       ^        results in:
        "                                   floor(var)
        map <C-H> ebdw%x<C-O>x
        nnoremap gp `[v`]
        
        " Insert a timestamp
        nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
        imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

        " Toggle paste mode on and off
        map <leader>v :setlocal paste!<cr>
        
        " run ctags in current directory
        filetype plugin on
        map <C-F12> :!ctags -R -I --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

        " Tagbar shortcut
        nmap <F8> :TagbarToggle<CR>
        
        " File finder
        nmap <Leader>t :FZF<CR>
        nmap <Leader>h :Ag<CR>
        
        let g:syntastic_cpp_compiler = 'clang++'
        let g:syntastic_cpp_compiler_options = ' -std=c++11'
        let g:syntastic_c_include_dirs = [ 'src', 'build' ]
        let g:syntastic_cpp_include_dirs = [ 'src', 'build' ]

        let g:ycm_autoclose_preview_window_after_completion = 1

        let g:zig_fmt_autosave = 1

        set bg=dark
      '';

      vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
      vimrcConfig.vam.pluginDictionaries = [
        { names = [
          "Syntastic"
          "Tagbar"
          "fzfWrapper"
          "fzf-vim"
        ]; }
      ];
    };
    all = pkgs.buildEnv {
      name = "all";
      paths = [
        ag
        ctags
        my_vim
        wolfebin
        #youtube-dl
        signal-desktop
        wineWowPackages.base
      ];
    };
  };
}
