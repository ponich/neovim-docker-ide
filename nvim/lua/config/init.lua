-- ============================================
-- Config Module Loader
-- ============================================

-- Load configuration modules in order
require("config.options")    -- Basic Vim options
require("config.clipboard")  -- Clipboard with OSC 52 support (for Docker)
require("config.keyboard")   -- Keyboard layout settings (Russian support)
require("config.lazy")       -- Plugin manager setup
require("keymaps")           -- Keymaps
