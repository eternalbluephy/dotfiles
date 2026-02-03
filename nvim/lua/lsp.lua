vim.lsp.enable "lua_ls"
vim.lsp.enable "clangd"

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- LSP keymaps
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "LSP: Goto Definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Goto Declaration" })
	end
})
