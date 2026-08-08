vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"

-- Tab & Indentations
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.wrap = false
opt.laststatus = 3

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Looks & Feel
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 8

opt.colorcolumn = "0"
opt.signcolumn = "yes"
opt.cmdheight = 0

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- File Navigation
opt.isfname:append("@-@")

-- Spilt Window
opt.splitright = true
opt.splitbelow = true

-- Text Yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Undo dir
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
