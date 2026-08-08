vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
})

-- Mason
require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "󰄳",
			package_pending = "󰦬",
			package_uninstalled = "󰚌",
		},
	},
})

local ensure_installed = {
	"lua_ls",
	"ts_ls",
	"html",
	"cssls",
	"tailwindcss",
	"astro",
	"pyright",
	"rust_analyzer",
}
require("mason-lspconfig").setup({
	ensure_installed = ensure_installed,
})

-- Blink auto complete
local blink = require("blink.cmp")

blink.build():pwait()
blink.setup({
	keymap = {
		preset = "enter",
	},

	sources = {
		default = {
			"lsp",
			"path",
			"buffer",
		},
	},
})

-- Lsp
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},

			diagnostics = {
				globals = { "vim", "hl" },
			},

			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},

			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
	},
})
vim.lsp.enable("ts_ls")

vim.lsp.enable("astro")
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("pyright")

-- Formater
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },

		astro = { "prettierd" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },

		html = { "prettierd" },
		css = { "prettierd" },
		json = { "prettierd" },
		markdown = { "prettierd" },

		python = { "ruff_format" },

		rust = { "rustfmt" },
	},

	format_on_save = {
		timeout_ms = 500,
	},
})
