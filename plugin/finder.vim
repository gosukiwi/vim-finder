" Vim Finder plugin
" Wrapper around Vim's grep to make things easier
" Author: Federico Ramirez <fedra.arg@gmail.com>
" Licence: MIT

" Give the user a chance to not load the plugin, also discard the possibility
" of loading it more than once
if exists("g:loaded_finder")
  finish
endif
let g:loaded_finder = 1

" Save the compability mode, set to no compatible and reset once we are done
let s:save_cpo = &cpo
set cpo&vim

" <Leader>g maps to <Plug>FinderGrep if not defined already in .vimrc
if !hasmapto('<Plug>FinderGrep')
  map <unique> <Leader>g  <Plug>FinderGrep
endif
" Map <Plug>FinderGrep to <SID>Grep
noremap <unique> <script> <Plug>FinderGrep  <SID>Grep
" Map <SID>Grep to function call Grep
noremap <SID>Grep  :call <SID>Grep()<CR>

" Grep function itself, simply asks for regex and perform search. Show results
" as soon as it's done searching
function s:Grep()
  let filter = input("Search in project: ")
  execute "vimgrep /" . filter . "/gj **/*"
  execute "cw"
endfunction

" Return compatibility mode to the value it was before
let &cpo = s:save_cpo
