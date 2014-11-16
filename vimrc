set et ts=2 sts=2 sw=2

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

if has("autocmd")
  filetype on
  autocmd FileType make setlocal noet ts=4 sts=4 sw=4
  " autocmd BufNewFile,BufRead *.rss setfiletype xml
endif

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
"nmap _= :call Preserve("normal gg=G")<CR>
