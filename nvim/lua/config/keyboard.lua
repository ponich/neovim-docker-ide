-- ============================================
-- Keyboard Layout Configuration
-- Russian Layout Support
-- ============================================

-- Enable langmap for Russian layout support in Normal mode
-- This allows using Vim commands with Russian keyboard layout
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- Alternative: Use iminsert for automatic layout switching
-- Uncomment if you prefer automatic switching to English in Insert mode
-- vim.opt.iminsert = 0  -- English in Insert mode by default
-- vim.opt.imsearch = 0  -- English in Search mode by default
