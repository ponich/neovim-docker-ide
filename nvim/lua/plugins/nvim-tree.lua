-- ============================================
-- nvim-tree: File Explorer
-- ============================================

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- File icons
    },
    config = function()
        -- Disable netrw (built-in file explorer) at the very start
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            -- Disable default window picker
            disable_netrw = true,
            hijack_netrw = true,

            -- Update focused file
            update_focused_file = {
                enable = true,
                update_root = false,
            },

            -- View settings
            view = {
                width = 35,
                side = "left",
                number = false,
                relativenumber = false,
            },

            -- Renderer settings
            renderer = {
                highlight_git = true,
                highlight_opened_files = "name",
                root_folder_label = ":~:s?$?/..?",
                indent_markers = {
                    enable = true,
                },
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = true,
                        git = false,
                    },
                    glyphs = {
                        default = "",
                        symlink = "",
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
            },

            -- Git integration
            git = {
                enable = true,
                ignore = false,
                timeout = 400,
            },

            -- Filesystem watchers
            filesystem_watchers = {
                enable = true,
            },

            -- Actions
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                    window_picker = {
                        enable = true,
                    },
                },
            },

            -- Filters
            filters = {
                dotfiles = false,
                custom = { ".git", "node_modules", ".cache" },
            },
        })

        -- Keymaps
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        -- Toggle nvim-tree
        keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle file explorer" }))

        -- Focus nvim-tree
        keymap("n", "<leader>ef", "<cmd>NvimTreeFocus<cr>", vim.tbl_extend("force", opts, { desc = "Focus file explorer" }))

        -- Find current file in tree
        keymap("n", "<leader>ee", "<cmd>NvimTreeFindFile<cr>", vim.tbl_extend("force", opts, { desc = "Find current file in explorer" }))
    end,
}
