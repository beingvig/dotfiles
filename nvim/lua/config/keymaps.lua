vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exits insert mode" })
keymap.set({ "n", "x" }, "d", '"_d', { noremap = true, silent = true, desc = "Delete without yanking" })
keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- search
keymap.set("n", "<Esc>", "<cmd>nohl<CR>", { desc = "Clear search highlights", silent = true })
keymap.set(
	"n",
	"<leader>gr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" }
)

-- movement
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })
-- selection
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

keymap.set("n", "<A-j>", "<cmd>t.<CR>", { desc = "Duplicate line" })
keymap.set("x", "<leader>d", ":t'><CR>", { remap = false, desc = "Duplicate selection" })

-- native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
