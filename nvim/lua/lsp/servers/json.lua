-- ============================================
-- JSON Language Server
-- ============================================

return {
    settings = {
        json = {
            schemas = {
                {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json",
                },
                {
                    fileMatch = { "package-lock.json" },
                    url = "https://json.schemastore.org/package-lock.json",
                },
                {
                    fileMatch = { "tsconfig.json" },
                    url = "https://json.schemastore.org/tsconfig.json",
                },
                {
                    fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                    url = "https://json.schemastore.org/prettierrc.json",
                },
                {
                    fileMatch = { ".eslintrc", ".eslintrc.json" },
                    url = "https://json.schemastore.org/eslintrc.json",
                },
                {
                    fileMatch = { "composer.json" },
                    url = "https://composer.json.schemastore.org/",
                },
            },
            maxProblems = 1000,
            format = {
                enable = true,
                keepLines = false,
            },
        },
    },
}
