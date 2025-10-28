-- ============================================
-- LSP Handlers and Diagnostics Configuration
-- ============================================

local vim = vim
local api = vim.api

-- Configure LSP logging and settings
vim.lsp.set_log_level(vim.log.levels.WARN)

-- Virtual text toggle state
local virtual_text_enabled = true

-- Configure diagnostics appearance
local function setup_diagnostics()
    vim.diagnostic.config({
        virtual_text = virtual_text_enabled and {
            prefix = "● ",
            spacing = 4,
            source = "if_many",
        } or false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })
end

-- Initial setup
setup_diagnostics()

-- Setup diagnostic signs
local signs = { Error = "✖", Warn = "⚠", Hint = "💡", Info = "ℹ" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Highlight groups for diagnostics
vim.cmd([[
    highlight DiagnosticUnderlineError guisp=red gui=undercurl
    highlight DiagnosticUnderlineWarn guisp=orange gui=undercurl
    highlight DiagnosticUnderlineInfo guisp=blue gui=undercurl
    highlight DiagnosticUnderlineHint guisp=green gui=undercurl
]])

-- Keymap to toggle virtual text
vim.keymap.set("n", "<Leader>dv", function()
    virtual_text_enabled = not virtual_text_enabled
    setup_diagnostics()
    local status = virtual_text_enabled and "enabled" or "disabled"
    vim.notify("Virtual text " .. status, vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Toggle virtual text diagnostics" })

-- LSP on_attach - called when a language server attaches to a buffer
local function on_attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Setup keybindings for LSP
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Navigation
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, vim.tbl_extend("force", opts, { desc = "Find references" }))
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

    -- Hover and diagnostics
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_extend("force", opts, { desc = "Hover information" }))
    vim.keymap.set("n", "<Leader>k", function() vim.lsp.buf.signature_help() end, vim.tbl_extend("force", opts, { desc = "Signature help" }))

    -- Diagnostics
    vim.keymap.set("n", "<Leader>dd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open diagnostics" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

    -- Refactoring
    vim.keymap.set("n", "<Leader>rn", function() vim.lsp.buf.rename() end, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    vim.keymap.set("n", "<Leader>ca", function() vim.lsp.buf.code_action() end, vim.tbl_extend("force", opts, { desc = "Code actions" }))
    vim.keymap.set("v", "<Leader>ca", function() vim.lsp.buf.code_action() end, vim.tbl_extend("force", opts, { desc = "Code actions" }))

    -- Workspace
    vim.keymap.set("n", "<Leader>wa", function() vim.lsp.buf.add_workspace_folder() end, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
    vim.keymap.set("n", "<Leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))

    -- Format code
    vim.keymap.set("n", "<Leader>fm", function()
        vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "Format code" }))

    -- Document symbols
    vim.keymap.set("n", "<Leader>fs", function() vim.lsp.buf.document_symbol() end, vim.tbl_extend("force", opts, { desc = "Document symbols" }))
    vim.keymap.set("n", "<Leader>ws", function() vim.lsp.buf.workspace_symbol() end, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

    -- Set up server-specific capabilities
    if client.supports_method("textDocument/formatting") then
        vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"

        -- Auto-format on save for certain file types
        local filetypes_to_format = { "typescript", "javascript", "vue", "json", "yaml" }
        if vim.tbl_contains(filetypes_to_format, vim.bo[bufnr].filetype) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end
end

-- Setup capabilities with cmp support
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Return handlers and defaults for use in configurations
return {
    on_attach = on_attach,
    capabilities = capabilities,
}
