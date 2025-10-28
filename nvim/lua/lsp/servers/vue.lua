-- ============================================
-- Vue Language Server (Volar)
-- ============================================

return {
    filetypes = { "vue", "typescript", "javascript" },
    init_options = {
        typescript = {
            userPreferences = {
                preferredTagNameCase = "auto",
                preferredAttrNameCase = "auto",
                lazyComponentResolution = false,
                experimentalRfc3040 = true,
            },
        },
        languageFeatures = {
            implementation = true,
            references = true,
            definition = true,
            typeDefinition = true,
            callHierarchy = true,
            hover = true,
            rename = true,
            renameFileRefactoring = true,
            signatureHelp = true,
            codeAction = true,
            workspaceSymbol = true,
            completion = {
                defaultTagNameCase = "auto",
                defaultAttrNameCase = "auto",
            },
        },
    },
    settings = {
        vue = {
            updateImportsOnFileMove = {
                enabled = true,
            },
            autoInsert = {
                dotValue = true,
                bracketSpacing = true,
            },
            codeActions = {
                enabled = true,
            },
            inlayHints = {
                missingProps = false,
                optionsWrapper = false,
                funcSuggestions = false,
            },
        },
    },
}
