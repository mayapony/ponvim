nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
nnoremap zc :call VSCodeNotify('editor.fold')<CR>
nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>

function! MoveCursor(direction) abort
		if(reg_recording() == '' && reg_executing() == '')
				return 'g'.a:direction
		else
				return a:direction
		endif
endfunction

nmap <expr> j MoveCursor('j')
nmap <expr> k MoveCursor('k')
