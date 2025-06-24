return {
	"folke/snacks.nvim",
	lazy = false,
	opts = {
		picker = {
			matcher = {
				frecency = true,
				cwd_bonus = true,
				history_bonus = true,
			},
			formatters = {
				icon_width = 3,
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("snacks").picker.smart()
			end,
			desc = "Smart Find Files"
		},
		{
			"<leader>fr",
			function()
				require("snacks").picker.recent()
			end,
			desc = "Find Recent Files"
		}
	}
}
