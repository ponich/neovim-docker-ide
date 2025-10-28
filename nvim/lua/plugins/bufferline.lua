-- ============================================
-- Bufferline: Buffer/Tab Line
-- ============================================

return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers", -- set to "tabs" to only show tabpages instead
                numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,
                indicator = {
                    icon = "▎",
                    style = "icon",
                },
                buffer_close_icon = "",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                max_name_length = 18,
                max_prefix_length = 15,
                truncate_names = true,
                tab_size = 20,
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or " ")
                        s = s .. n .. sym
                    end
                    return s
                end,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
                color_icons = false,
                show_buffer_icons = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = true,
                show_duplicate_prefix = true,
                persist_buffer_sort = true,
                separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { "any", "any" }
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
                sort_by = "insert_after_current",
            },
        })

        -- Keymaps
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        -- Navigate buffers
        keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))
        keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))

        -- Move buffers
        keymap("n", "<leader>bl", "<cmd>BufferLineMoveNext<cr>", vim.tbl_extend("force", opts, { desc = "Move buffer right" }))
        keymap("n", "<leader>bh", "<cmd>BufferLineMovePrev<cr>", vim.tbl_extend("force", opts, { desc = "Move buffer left" }))

        -- Pick buffer
        keymap("n", "<leader>bp", "<cmd>BufferLinePick<cr>", vim.tbl_extend("force", opts, { desc = "Pick buffer" }))

        -- Close buffers
        keymap("n", "<leader>bc", "<cmd>bdelete<cr>", vim.tbl_extend("force", opts, { desc = "Close buffer" }))
        keymap("n", "<leader>bC", "<cmd>BufferLinePickClose<cr>", vim.tbl_extend("force", opts, { desc = "Pick buffer to close" }))
    end,
}
