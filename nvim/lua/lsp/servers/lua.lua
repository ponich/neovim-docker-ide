-- ============================================
-- Lua Language Server
-- ============================================

return {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = {
                    "vim",
                    -- Test globals
                    "describe", "it", "before_each", "after_each", "assert",
                },
                disable = { "lowercase-global", "undefined-field" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Disable",
            },
            hover = {
                expandable = true,
            },
            hint = {
                enable = true,
                setType = true,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                parameterHints = "Disable",
                await = true,
                arrayIndex = "Disable",
            },
        },
    },
}
