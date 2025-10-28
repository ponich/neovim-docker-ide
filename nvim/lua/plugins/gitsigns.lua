-- ============================================
-- Gitsigns - Git diff signs in gutter
-- ============================================

return {
    "lewis6991/gitsigns.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                follow_files = true,
            },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = " <author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000,
            preview_config = {
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            yadm = {
                enable = false,
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                -- Navigation
                vim.keymap.set("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, { buffer = bufnr, desc = "Next hunk" })

                vim.keymap.set("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, { buffer = bufnr, desc = "Previous hunk" })

                -- Actions
                vim.keymap.set("n", "<Leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
                vim.keymap.set("v", "<Leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { buffer = bufnr, desc = "Stage hunk" })

                vim.keymap.set("n", "<Leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
                vim.keymap.set("n", "<Leader>hd", gitsigns.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
                vim.keymap.set("n", "<Leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
                vim.keymap.set("n", "<Leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, { buffer = bufnr, desc = "Blame line" })

                -- Text object
                vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select hunk" })
            end,
        })
    end,
}
