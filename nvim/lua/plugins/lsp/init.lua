return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		"mason.nvim",
	},
	init = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				vim.keymap.set("n", "gd", function()
					local params = vim.lsp.util.make_position_params(0, "utf-8")
					vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
						if not result or vim.tbl_isempty(result) then
							vim.notify("No definition found")
						else
							require("snacks").picker.lsp_definitions()
						end
					end)
				end)

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				-- Inlay hint
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					vim.notify("inlay_hints on")
					vim.lsp.inlay_hint.enable(true)
				end
			end
		})
	end,
	opts = function()
		local icons = require("config").icons

		return {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
						[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
						[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
						[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
					},
				},
			},
			inlay_hints = {
				enabled = true,
				exclude = { "vue" },
			},
			codelens = {
				enabled = true,
			},
			capabilities = {
				workspace = {
					fileOperations = {
						didRename = true,
						willRename = true,
					},
				},
			},
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
		}
	end,
	config = function(_, opts)
		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local servers = require("plugins.lsp.servers")
		local blink = require("blink.cmp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			blink.get_lsp_capabilities(),
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities)
			}, servers[server] or {})
			require("lspconfig")[server].setup(server_opts)
		end
		for server, _ in pairs(servers) do
			setup(server)
		end
	end
}
