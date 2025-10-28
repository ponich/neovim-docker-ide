-- ============================================
-- HTML Language Server
-- ============================================

return {
    settings = {
        html = {
            format = {
                templating = true,
                wrapLineLength = 120,
                wrapAttributes = "auto",
                unformatted = { "code", "pre", "em", "strong", "span" },
            },
            validate = {
                scripts = true,
                styles = true,
            },
            hover = {
                documentation = true,
                references = true,
            },
        },
    },
}
