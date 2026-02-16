return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{
			"<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal"
		},
	},
	opts = {
		size = 10,
		on_create = function(t)
			vim.keymap.set("n", "q", function()
        t:toggle()
      end, { buffer = t.bufnr, silent = true, desc = "Close ToggleTerm" })
			vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { buffer = t.bufnr, silent = true, desc = "Terminal: Normal Mode"})
		end
	}
}
