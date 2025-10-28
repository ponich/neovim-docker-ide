-- ============================================
-- Lazy.nvim Plugin Manager Setup
-- ============================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Ensure lazy.nvim is available (pre-installed in Docker, or fallback to clone)
if not vim.loop.fs_stat(lazypath) then
    -- Ensure lazy directory exists
    local lazydir = vim.fn.fnamemodify(lazypath, ":h")
    vim.fn.mkdir(lazydir, "p")

    -- Clone lazy.nvim as fallback for non-Docker environments
    local result = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        error("Failed to bootstrap lazy.nvim:\n" .. result)
    end
end

-- Add lazy.nvim to runtime path
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
