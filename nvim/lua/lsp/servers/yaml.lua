-- ============================================
-- YAML Language Server
-- ============================================

return {
    settings = {
        yaml = {
            keyOrdering = false,
            format = {
                enable = true,
                singleQuote = false,
                bracketSpacing = true,
            },
            validate = true,
            hover = true,
            completion = true,
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/json/",
            },
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
                ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
            },
        },
    },
}
