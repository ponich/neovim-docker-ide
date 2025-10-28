-- ============================================
-- Basic Vim Options
-- ============================================

local opt = vim.opt

-- ============================================
-- UI and Appearance
-- ============================================

-- Line numbers
opt.number = true           -- Show line numbers
opt.relativenumber = false  -- Show absolute line numbers (not relative)
opt.signcolumn = "yes"      -- Always show sign column (for git, diagnostics, etc.)

-- Color and theme support
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.background = "dark"     -- Dark background

-- Cursor line
opt.cursorline = true       -- Highlight current line

-- Command line
opt.cmdheight = 1           -- Command line height
opt.showcmd = true          -- Show command in status line
opt.showmode = false        -- Don't show mode (statusline will show it)

-- Scrolling
opt.scrolloff = 8           -- Min number of lines above/below cursor
opt.sidescrolloff = 8       -- Min number of columns left/right of cursor

-- Splits
opt.splitright = true       -- Vertical splits open to the right
opt.splitbelow = true       -- Horizontal splits open below

-- ============================================
-- Indentation and Formatting
-- ============================================

opt.tabstop = 4             -- Number of spaces tabs count for
opt.softtabstop = 4         -- Number of spaces for tab in insert mode
opt.shiftwidth = 4          -- Size of an indent
opt.expandtab = true        -- Use spaces instead of tabs
opt.smartindent = true      -- Smart autoindenting on new lines
opt.autoindent = true       -- Copy indent from current line when starting new line

-- Wrapping
opt.wrap = false            -- Don't wrap lines
opt.linebreak = true        -- Wrap on word boundary

-- ============================================
-- Search
-- ============================================

opt.ignorecase = true       -- Ignore case in search
opt.smartcase = true        -- Override ignorecase if search contains uppercase
opt.hlsearch = true         -- Highlight search results
opt.incsearch = true        -- Show search matches as you type

-- ============================================
-- Files and Buffers
-- ============================================

-- Backups and swap
opt.backup = false          -- Don't create backup files
opt.writebackup = false     -- Don't create backup before overwriting
opt.swapfile = false        -- Don't use swap files

-- Undo
opt.undofile = true         -- Enable persistent undo
opt.undolevels = 10000      -- Maximum number of changes that can be undone

-- File encoding
opt.fileencoding = "utf-8"  -- File encoding
opt.encoding = "utf-8"      -- Internal encoding

-- ============================================
-- Editing
-- ============================================

-- Mouse
opt.mouse = "a"             -- Enable mouse in all modes

-- Clipboard - configured in config/clipboard.lua
-- Supports both local and system clipboard operations

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" } -- Completion options

-- Hidden buffers
opt.hidden = true           -- Allow hidden buffers with unsaved changes

-- Update time (for CursorHold events)
opt.updatetime = 250        -- Faster completion (default 4000ms)

-- Timeout
opt.timeoutlen = 300        -- Time to wait for mapped sequence (ms)

-- ============================================
-- Visual Elements
-- ============================================

-- Whitespace characters
opt.list = true
opt.listchars = {
    tab = "→ ",
    trail = "·",
    nbsp = "␣",
    extends = "⟩",
    precedes = "⟨"
}

-- Fill characters
opt.fillchars = {
    fold = " ",
    foldopen = "v",
    foldclose = ">",
    diff = "╱"
}

-- ============================================
-- Performance
-- ============================================

opt.lazyredraw = false      -- Don't redraw during macros (set to true for better performance)
opt.ttyfast = true          -- Fast terminal connection

-- ============================================
-- Folding (disabled by default)
-- ============================================

opt.foldenable = false      -- Disable folding by default
opt.foldmethod = "indent"   -- Fold based on indentation
opt.foldlevelstart = 99     -- Start with all folds open

-- ============================================
-- Miscellaneous
-- ============================================

-- Confirm instead of failing commands
opt.confirm = true

-- Don't show intro message
opt.shortmess:append("I")

-- Better window title
opt.title = true

-- Enable break indent
opt.breakindent = true

-- Decrease redraw time
opt.redrawtime = 1500

-- Enable spell checking (disabled by default, can be toggled)
opt.spell = false
opt.spelllang = { "en", "ru" }

-- Set grep program to ripgrep if available
if vim.fn.executable("rg") == 1 then
    opt.grepprg = "rg --vimgrep --no-heading --smart-case"
    opt.grepformat = "%f:%l:%c:%m"
end
