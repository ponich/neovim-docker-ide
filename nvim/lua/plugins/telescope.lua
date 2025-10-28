-- ============================================
-- Telescope: Fuzzy Finder
-- ============================================

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- Appearance
                prompt_prefix = " ",
                selection_caret = " ",
                entry_prefix = "  ",
                multi_icon = " ",

                -- Layout
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                -- Sorting
                sorting_strategy = "ascending",

                -- Behavior
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "dist/",
                    "build/",
                    "target/",
                    "vendor/",
                    "%.lock",
                },

                -- Mappings
                mappings = {
                    i = {
                        -- Navigation
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,

                        -- Close
                        ["<C-c>"] = actions.close,
                        ["<Esc>"] = actions.close,

                        -- Scroll preview
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,

                        -- Select
                        ["<CR>"] = actions.select_default,
                        ["<C-x>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-t>"] = actions.select_tab,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<Esc>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                    },
                },
            },

            pickers = {
                find_files = {
                    theme = "dropdown",
                    previewer = false,
                    hidden = true,
                },
                live_grep = {
                    theme = "dropdown",
                },
                buffers = {
                    theme = "dropdown",
                    previewer = false,
                    initial_mode = "normal",
                },
            },
        })

        -- Keymaps
        local keymap = vim.keymap.set
        local builtin = require("telescope.builtin")

        -- Files
        keymap("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
        keymap("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
        keymap("n", "<leader>fa", function()
            builtin.find_files({ no_ignore = true, hidden = true })
        end, { desc = "Find all files (including ignored)" })

        -- Search
        keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
        keymap("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })

        -- Buffers
        keymap("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })

        -- Git
        keymap("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
        keymap("n", "<leader>gf", builtin.git_bcommits, { desc = "Git file commits" })
        keymap("n", "<leader>gs", builtin.git_status, { desc = "Git status" })

        -- Vim
        keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
        keymap("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
        keymap("n", "<leader>fc", builtin.commands, { desc = "Commands" })
        keymap("n", "<leader>fo", builtin.vim_options, { desc = "Vim options" })
    end,
}
