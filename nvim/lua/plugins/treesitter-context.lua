-- ============================================
-- Treesitter Context - Show function context
-- ============================================

return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("treesitter-context").setup({
            enable = true,
            max_lines = 0,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "faded",
            mode = "cursor",
            separator = nil,
            zindex = 20,
            on_attach = nil,
        })

        vim.keymap.set("n", "[C", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { noremap = true, silent = true, desc = "Go to context" })
    end,
}
