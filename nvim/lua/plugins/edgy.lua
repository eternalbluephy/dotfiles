return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			animate = { enabled = false },
			left = {
				{
					ft = "neo-tree",
				}
			},
			bottom = {
				{
					ft = "snacks_terminal",
				}
			},
			wo = { winbar = false }
		}
	}
}
