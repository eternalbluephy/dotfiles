return {
	"williamboman/mason.nvim",
	event = { "BufReadPost", "BufNewFile", "VimEnter" },
	cmd = { "Mason", "MasonInstall" },
	keys = {
		{ "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
	},
	opts = {},
}
