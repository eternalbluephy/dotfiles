local map = vim.keymap.set

map("n", "<c-h>", "<c-w>h", { desc = "Go to Left Window" })
map("n", "<c-l>", "<c-w>l", { desc = "Go to Right Window" })

map("n", "<c-[>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<c-]>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
