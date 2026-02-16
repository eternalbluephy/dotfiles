local opt = vim.opt

opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.number = true
opt.scrolloff = 4
opt.sidescrolloff = 2
opt.cursorline = true
opt.winborder = "single"
opt.cmdheight = 0
opt.laststatus = 3
opt.clipboard = "unnamedplus"

-- For WSL, uncomment following snippet to improve speed:
vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf"
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf"
  },
  cache_enable = 0,
}

vim.g.health = { style = "float" }
