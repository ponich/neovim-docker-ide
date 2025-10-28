-- ============================================
-- Neovim Docker IDE - Main Configuration
-- ============================================

-- Set leader key early (before any mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Suppress deprecation warnings (some plugins use deprecated functions)
-- This prevents UI blocking during startup
vim.g.deprecation_warnings = false

-- Load core configuration modules
require("config")
