-- ============================================
-- LSPConfig - Language Server Configuration
-- ============================================

return {
    "neovim/nvim-lspconfig",
    version = "*",
    dependencies = {
        "williamboman/mason.nvim",
    },
    lazy = false,
    priority = 99,
    config = function()
        local lspconfig = require("lspconfig")

        -- Get defaults from handlers
        local defaults = require("lsp.handlers")

        -- Setup each language server
        local servers = {
            intelephense = require("lsp.servers.php"),
            html = require("lsp.servers.html"),
            cssls = require("lsp.servers.css"),
            jsonls = require("lsp.servers.json"),
            yamlls = require("lsp.servers.yaml"),
            lua_ls = require("lsp.servers.lua"),
        }

        -- Setup TypeScript - try ts_ls first (newer), then tsserver (older)
        local ts_config = require("lsp.servers.typescript")
        ts_config.on_attach = defaults.on_attach
        ts_config.capabilities = defaults.capabilities

        -- Try ts_ls first (nvim-lspconfig >= 0.1.7)
        if lspconfig.ts_ls then
            lspconfig.ts_ls.setup(ts_config)
        elseif lspconfig.tsserver then
            lspconfig.tsserver.setup(ts_config)
        else
            vim.notify(
                "TypeScript LSP server not found. Install typescript-language-server with :Mason or npm",
                vim.log.levels.WARN
            )
        end

        -- Setup all other servers with defaults
        for server_name, server_config in pairs(servers) do
            server_config.on_attach = defaults.on_attach
            server_config.capabilities = defaults.capabilities
            if lspconfig[server_name] then
                lspconfig[server_name].setup(server_config)
            else
                vim.notify(
                    "LSP server '" .. server_name .. "' not found. Install it with :Mason",
                    vim.log.levels.WARN
                )
            end
        end

        -- Setup Vue (Volar) manually
        local vue_config = require("lsp.servers.vue")
        vue_config.on_attach = defaults.on_attach
        vue_config.capabilities = defaults.capabilities
        if lspconfig.volar then
            lspconfig.volar.setup(vue_config)
        else
            vim.notify(
                "LSP server 'volar' (Vue) not found. Install it with :Mason",
                vim.log.levels.WARN
            )
        end
    end,
}
