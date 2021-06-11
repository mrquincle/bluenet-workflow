" In C++ layout,
" identation in switch statements
" Check http://vimdoc.sourceforge.net/htmldoc/indent.html#cinoptions-values
" :0 means case statements at same level as switch
" l1 means within case statements just one indent
" j1 means 'javascript corrections' for closures
set cinoptions=:0,l1,j1

" configure expanding of tabs for python, turn it on for bluenet
" Bart wants tabs, not spaces
au BufRead,BufNewFile *.py set expandtab

