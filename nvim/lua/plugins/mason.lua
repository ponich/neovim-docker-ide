-- ============================================
-- Mason - Language Server Package Manager
-- ============================================

return {
    "williamboman/mason.nvim",
    version = "*",
    lazy = false,
    priority = 100,
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
                width = 0.9,
                height = 0.9,
                border = "rounded",
            },
            PATH = "append",
            max_concurrent_installers = 4,
        })
    end,
}
