-- ============================================
-- Vim Fugitive - Git integration
-- ============================================

return {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse" },
    dependencies = {
        "tpope/vim-rhubarb", -- GitHub support for vim-fugitive
    },
    config = function()
        -- Git keybindings
        vim.keymap.set("n", "<Leader>gs", ":Git<CR>", { noremap = true, silent = true, desc = "Git status" })
        vim.keymap.set("n", "<Leader>ga", ":Git add %<CR>", { noremap = true, silent = true, desc = "Git add current file" })
        vim.keymap.set("n", "<Leader>gc", ":Git commit<CR>", { noremap = true, silent = true, desc = "Git commit" })
        vim.keymap.set("n", "<Leader>gC", ":Git commit --amend<CR>", { noremap = true, silent = true, desc = "Git commit amend" })
        vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { noremap = true, silent = true, desc = "Git blame" })
        vim.keymap.set("n", "<Leader>gL", ":Git log<CR>", { noremap = true, silent = true, desc = "Git log" })
        vim.keymap.set("n", "<Leader>gd", ":Gdiffsplit<CR>", { noremap = true, silent = true, desc = "Git diff split" })
        vim.keymap.set("n", "<Leader>gp", ":Git push<CR>", { noremap = true, silent = true, desc = "Git push" })
        vim.keymap.set("n", "<Leader>gP", ":Git pull<CR>", { noremap = true, silent = true, desc = "Git pull" })
        vim.keymap.set("n", "<Leader>gt", ":Git stash<CR>", { noremap = true, silent = true, desc = "Git stash" })
        vim.keymap.set("n", "<Leader>gT", ":Git stash pop<CR>", { noremap = true, silent = true, desc = "Git stash pop" })

        -- Fugitive specific settings
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "fugitive",
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                vim.keymap.set("n", "q", ":bdelete<CR>", { buffer = buf, noremap = true, silent = true })
            end,
        })
    end,
}
