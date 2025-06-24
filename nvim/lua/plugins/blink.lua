return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = { preset = "enter" },
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				}
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			menu = {
				draw = {
					treesitter = { "lsp" }
				}
			}
		},
		signature = {
			enabled = true,
		},
		cmdline = {
			enabled = false,
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		}
	},
	opts_extend = {
		"sources.default",
	}
}
