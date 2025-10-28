-- ============================================
-- Color Schemes: Nordic (true color) + Little Wonder (256 colors)
-- ============================================
-- Auto-detect terminal capabilities and use appropriate theme

return {
    -- Nordic for terminals with true color support
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        cond = function()
            -- Only use Nordic for iTerm2 or terminals with COLORTERM=truecolor
            local colorterm = os.getenv('COLORTERM')
            local term_program = os.getenv('TERM_PROGRAM')

            return colorterm == 'truecolor' or term_program == 'iTerm.app'
        end,
        config = function()
            require('nordic').setup({
                bold_keywords = false,
                italic_comments = true,
                transparent = {
                    bg = false,
                    float = false,
                },
                bright_border = false,
                reduced_blue = true,
                swap_backgrounds = false,
                cursorline = {
                    bold = false,
                    bold_number = true,
                    theme = 'dark',
                    blend = 0.85,
                },
                telescope = {
                    style = 'flat',
                },
                noice = {
                    style = 'classic',
                },
            })
            require('nordic').load()
        end,
    },

    -- Little Wonder for terminals without true color (fallback)
    {
        "VonHeikemen/little-wonder",
        lazy = false,
        priority = 1000,
        cond = function()
            -- Use for all terminals except iTerm2 and those with COLORTERM=truecolor
            local colorterm = os.getenv('COLORTERM')
            local term_program = os.getenv('TERM_PROGRAM')

            return not (colorterm == 'truecolor' or term_program == 'iTerm.app')
        end,
        config = function()
            -- Use lw-owl - best contrast for 256 color terminals
            vim.cmd.colorscheme('lw-owl')
        end,
    },
}
