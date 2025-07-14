return {
	"rebelot/heirline.nvim",
	event = "VeryLazy",
	config = function()
		local statusline = require("plugins.heirline.statusline")
		require("heirline").setup({
			statusline = statusline,
		})
	end
}
