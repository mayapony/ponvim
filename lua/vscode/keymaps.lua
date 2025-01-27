local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end
local function map_cmd(mode, lhs, cmd, opts)
  vim.keymap.set(mode, lhs, [[<cmd>lua require('vscode-neovim').call(']] .. cmd .. [[')<cr>]], opts)
end

-- ui
map_cmd("n", "<leader>uC", "workbench.action.selectTheme", { desc = "Change colorscheme" })
map_cmd("n", "<leader>uz", "workbench.action.toggleZenMode", {})

-- finder
map_cmd({ "n", "x" }, "<leader>.", "workbench.action.quickOpen", {})
map_cmd("n", "<leader>fp", "workbench.action.openRecent", { desc = "find project" })
map(
  "n",
  "<leader>fw",
  [[<Cmd>lua require('vscode-neovim').action('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } })<CR>]],
  {}
)

-- redo undo
map_cmd("n", "u", "undo", { desc = "undo" })
map_cmd("n", "<C-r>", "redo", { desc = "redo" })

-- code action
map_cmd({ "n", "x" }, "<leader>cr", "editor.action.rename", {})
map_cmd({ "n", "x" }, "<leader>ca", "keyboard-quickfix.openQuickFix", {})

-- navigation
map_cmd({ "n", "x" }, "]e", "editor.action.marker.next", {})
map_cmd({ "n", "x" }, "[e", "editor.action.marker.prev", {})

-- close
map_cmd({ "n", "x" }, "<leader>qo", "workbench.action.closeOtherEditors", { desc = "Close other editors" })
map_cmd({ "n", "x" }, "<leader>qa", "workbench.action.closeAllEditors", { desc = "Close all editors" })
map_cmd({ "n", "x" }, "<leader>qq", "workbench.action.closeActiveEditor", { desc = "Close active editor" })

-- fold
map_cmd("n", "zM", "editor.foldAll", {})
map_cmd("n", "zR", "editor.unfoldAll", {})
map_cmd("n", "zc", "editor.fold", {})
map_cmd("n", "zC", "editor.foldRecursively", {})
map_cmd("n", "zo", "editor.unfold", {})
map_cmd("n", "zO", "editor.unfoldRecursively", {})
map_cmd("n", "za", "editor.toggleFold", {})

vim.cmd([[
	function! MoveCursor(direction) abort
			if(reg_recording() == '' && reg_executing() == '')
					return 'g'.a:direction
			else
					return a:direction
			endif
	endfunction

	nmap <expr> j MoveCursor('j')
	nmap <expr> k MoveCursor('k')
]])

-- window manager
map_cmd({ "n", "x" }, "<leader>wt", "workbench.action.toggleEditorWidths", {})
vim.cmd([[
" window/splits management
nnoremap <C-w>= <Cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
nnoremap <C-w>_ <Cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

" window navigation
nnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <C-w><C-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
xnoremap <C-w><C-j> <Cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
nnoremap <C-w><C-k> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
xnoremap <C-w><C-k> <Cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
nnoremap <C-w><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
xnoremap <C-w><C-h> <Cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
nnoremap <C-w><C-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>
xnoremap <C-w><C-l> <Cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

nnoremap <C-w>w <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
xnoremap <C-w>w <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
]])

----------------
-- Extension:
----------------
-- change-case
map_cmd({ "n", "x" }, "<leader>ck", "extension.changeCase.commands", {})
