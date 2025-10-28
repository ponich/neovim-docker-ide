-- ============================================
-- Lazy.nvim Plugin Manager Setup
-- ============================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- Ensure lazy directory exists
    vim.fn.mkdir(vim.fn.fnamemodify(lazypath, ":h"), "p")

    -- Clone lazy.nvim with error checking
    local result = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })

    -- Check for errors
    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to bootstrap lazy.nvim:\n" .. result, vim.log.levels.ERROR)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- Plugins will be loaded from nvim/lua/plugins/
    spec = {
        { import = "plugins" },
    },

    -- Plugin installation settings
    install = {
        colorscheme = { "default" },
    },

    -- UI settings
    ui = {
        border = "rounded",
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },

    -- Performance settings
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },

    -- Change detection
    change_detection = {
        enabled = true,
        notify = false, -- Don't show notifications on config change
    },
})
