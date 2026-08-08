vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
fzf.setup({
	winopts = {
		height = 0.85,
		width = 0.80,
		row = 0.35,
		col = 0.50,
		fullscreen = false,
		border = "rounded",
	},
	fzf_opts = {
		["--ansi"] = true,
		["--info"] = "inline-right",
		["--height"] = "100%",
		["--layout"] = "reverse",
	},
})

vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>f/", fzf.live_grep)
