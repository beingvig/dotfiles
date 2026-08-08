vim.pack.add({
    { src = 'https://github.com/nvim-mini/mini.notify', version = 'stable' },
    { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
})


local MiniFiles = require("mini.files")

MiniFiles.setup({
    mappings = {
        go_in = "<CR>",
        go_in_plus = "L",
        go_out = "_",
        go_out_plus = "H",
    },
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

require('mini.notify').setup()
