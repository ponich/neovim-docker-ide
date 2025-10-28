-- ============================================
-- Keyboard Layout Configuration
-- Russian Layout Support
-- ============================================

-- Enable langmap for Russian layout support in Normal mode
-- This allows using Vim commands with Russian keyboard layout
vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- Fix for Command mode with Russian layout
-- langmap doesn't work in Command mode, so we need to remap manually
local function setup_russian_langmap()
    local rus = "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
    local eng = "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>"

    for i = 1, #rus do
        local ru_char = rus:sub(i, i)
        local en_char = eng:sub(i, i)
        vim.keymap.set('c', ru_char, en_char, { noremap = true })
    end
end

setup_russian_langmap()

-- Note: Automatic keyboard layout switching requires OS-level integration
-- which is not available in Docker containers.
-- Best practice: Use keyboard shortcuts in your OS to switch layouts:
-- - macOS: Cmd+Space or Ctrl+Space
-- - Or use a tool like Karabiner-Elements for advanced key remapping
--
-- Alternative for native Neovim (outside Docker):
-- Install im-select and use the im-select.nvim plugin
