return {
	"rebelot/heirline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local statusline = require("plugins.heirline.statusline")
		require("heirline").setup({
			statusline = statusline,
		})
	end
}
