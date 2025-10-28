-- ============================================
-- Treesitter Textobjects - Motion and selection
-- ============================================

return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",
                        ["a,"] = "@parameter.outer",
                        ["i,"] = "@parameter.inner",
                        ["aa"] = "@assignment.outer",
                        ["ia"] = "@assignment.inner",
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V",  -- linewise
                        ["@class.outer"] = "V",     -- linewise
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]a"] = "@parameter.inner",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]C"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[a"] = "@parameter.inner",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[C"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<Leader>ms"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<Leader>mS"] = "@parameter.inner",
                    },
                },
            },
        })

        -- Wordwise motions
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    end,
}
