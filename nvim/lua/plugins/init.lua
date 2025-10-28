-- ============================================
-- Plugins List
-- ============================================

return {
    -- Core plugins from Phase 1
    require("plugins.colorscheme"),
    require("plugins.lualine"),
    require("plugins.bufferline"),
    require("plugins.nvim-tree"),
    require("plugins.telescope"),

    -- Phase 2: LSP and Language Servers
    require("plugins.mason"),
    require("plugins.lspconfig"),
    require("plugins.luasnip"),
    require("plugins.nvim-cmp"),
}
