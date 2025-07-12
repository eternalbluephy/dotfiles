local palette = require("catppuccin.palettes").get_palette "mocha"
local utils = require "heirline.utils"
local conditions = require "heirline.conditions"
local icons = require("config").icons
local colors = {
	diag_error = utils.get_highlight("DiagnosticError").fg,
	diag_warn = utils.get_highlight("DiagnosticWarn").fg,
	diag_info = utils.get_highlight("DiagnosticInfo").fg,
	diag_hint = utils.get_highlight("DiagnosticHint").fg
}

local M = {}

M.Mode = {
	init = function(self)
		self.mode = vim.fn.mode(1)
	end,
	static = {
		mode_colors = {
			n = palette.blue,
			nt = palette.red,
			i = palette.green,
			v = palette.mauve,
			V = palette.mauve,
      ["\22"] = palette.mauve,
      c = palette.red,
      s = palette.pink,
      S = palette.pink,
      ["\19"] = palette.pink,
      R = palette.peach,
      r = palette.peach,
      ["!"] = palette.red,
      t = palette.green,
		}
	},
	hl = function(self)
		local mode = self.mode:sub(1, 1)
		return { fg = palette.base, bg = self.mode_colors[mode], bold = true }
	end,
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			pcall(vim.cmd, "redrawstatus")
		end),
	},
}

M.ModeLeftIndicator = {
	provider = "▌",
}

M.ModeLeft = utils.insert(M.Mode, M.ModeLeftIndicator)

M.ModeRightIndicator = {
	provider = "▐",
}

M.ModeRight = utils.insert(M.Mode, M.ModeRightIndicator)

M.Diagnostics = {
	condition = conditions.has_diagnostics,
	static = {
		error_icon = icons.diagnostics.Error,
		warn_icon = icons.diagnostics.Warn,
		info_icon = icons.diagnostics.Info,
		hint_icon = icons.diagnostics.Hint,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { vim.diagnostic.severity.WARN })
		self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		self.hints = #vim.diagnostic.get(0, { vim.diagnostic.severity.HINT })
	end,
	update = { "DiagnosticChanged", "BufEnter" },
	{
		provider = function(self)
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = colors.diag_error }
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = colors.diag_warn }
	},
	{
		provider = function(self)
			return self.infos > 0 and (self.info_icon .. self.infos .. " ")
		end,
		hl = { fg = colors.diag_info }
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
		end,
		hl = { fg = colors.diag_hint }
	},
}

M.FileName = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

M.FileIcon = {
	init = function(self)
		local filename = self.filename
		local ext = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, ext, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end
}

M.FileNameText = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":t")
		if filename == "" then return "[No Name]" end
		return filename
	end
}

M.FileNameBlock = utils.insert(M.FileName, M.FileIcon, M.FileNameText)

M.Git = {
	condition = conditions.is_git_repo,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0
	end,
	hl = { fg = palette.flamingo },
	{
		provider = function(self)
			return "󰘬 " .. self.status_dict.head .. "  "
		end
	}
}

M.LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "]"
	end,
	hl = { fg = palette.surface2, bold = true }
}

M.Ruler = {
	-- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
	provider = "%(%l:%c%) %P"
}


return M
