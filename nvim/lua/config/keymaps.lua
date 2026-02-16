local map = vim.keymap.set

map("n", "<c-z>", "u", { desc = "Undo" })
map("n", "u", "<nop>", { desc = "Disable Default Undo Key" })

map("n", "<leader>bd", function() require("snacks").bufdelete() end, { desc = "Delete Buffer" })

map("n", "<c-h>", "<c-w>h", { desc = "Go to Left Window" })
map("n", "<c-l>", "<c-w>l", { desc = "Go to Right Window" })
map("n", "<c-k>", "<c-w>k", { desc = "Go to Upper Window" })
map("n", "<c-j>", "<c-w>j", { desc = "Go to Lower Window" })

map("n", "<c-right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<c-left>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
map("n", "<c-up>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<c-down>", "<cmd>resize +2<cr>", { desc = "Increase Window Height "})

map("n", "<leader>cd", function() vim.diagnostic.open_float({ source = true }) end, { desc = "Show Diagnostics" })
