vim.pack.add({
	"https://github.com/neanias/everforest-nvim.git",
})

-- Theme --
vim.cmd([[colorscheme everforest]])

-- Mini files --
require("plugins.mini")

-- Lsp Config
require("plugins.lsp")

-- Statusline
require("plugins.statusline")

-- Fuzzy Finder
require("plugins.finder")
