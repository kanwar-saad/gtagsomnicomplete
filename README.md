VIM omnicomplete plugin for Gtags
=================================

Description:
------------
    Gtags are quite widely used tags but there seems to be no support for vim autocomplete. This plugin provides vim omnicomplete support using Gtags.

How to Use:
-----------
- Configure your Gtags for your code repository as described in 
  http://www.gnu.org/software/global/globaldoc_toc.html
  After this step you should be able to run command 'global --help' from your project directory.

- Download and Install gtagsomnicomplete.vim in your vim plugins directory. 
  Usually it is ~/.vim/plugin/

- In your vimrc file put this line,
    autocmd FileType c set omnifunc=gtagsomnicomplete#Complete
  You can replace 'c' from above line to whatever language you are using gtags with.

- Open a file in vim from your project. Start writing and after atleast 3 characters,
  press <CTRL + X> then <CTRL + O> to open autocomplete menu.

- You can customize omnicomplete according to your liking. 
  http://vim.wikia.com/wiki/VimTip1228
  http://vim.wikia.com/wiki/VimTip1386

