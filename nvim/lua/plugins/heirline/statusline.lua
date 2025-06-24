local components = require("plugins.heirline.components")

local Align = { provider = "%=" }
local Space = { provider = " " }

local DefaultStatusLine = {
	components.ModeLeft,
	Space,
	components.Git,
	Space,
	components.FileNameBlock,
	Space,
	components.Diagnostics,
	Align,
	components.LSPActive,
	Space,
	components.Ruler,
	Space,
	components.ModeRight,
}

return DefaultStatusLine
