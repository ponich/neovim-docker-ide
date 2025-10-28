-- ============================================
-- Clipboard Configuration
-- ============================================
--
-- Smart clipboard provider that auto-detects environment:
-- 1. Local Neovim on macOS: Uses built-in pbcopy/pbpaste (perfect!)
-- 2. Docker container: Uses OSC 52 escape sequences
--
-- For local use: Just use y/p normally - works perfectly with macOS clipboard
-- For Docker: Use y to copy (OSC 52), then Cmd+Shift+V + p to paste

-- ============================================
-- Environment Detection
-- ============================================

local function is_in_docker()
    -- Check if pbcopy exists (won't exist in Docker)
    if vim.fn.executable('pbcopy') == 1 and vim.fn.executable('pbpaste') == 1 then
        return false  -- We have macOS commands, so we're on local Mac
    end

    -- Check for Docker-specific paths
    if vim.fn.filereadable('/.dockerenv') == 1 then
        return true
    end

    -- Default to Docker if we don't have pbcopy/pbpaste
    return true
end

local IN_DOCKER = is_in_docker()

-- ============================================
-- Local macOS Clipboard Provider
-- ============================================

local function make_macos_clipboard_provider()
    return {
        name = 'macOS',
        copy = {
            ['+'] = function(lines)
                -- Use pbcopy directly - simple and works perfectly
                local text = table.concat(lines, '\n')
                -- Use echo to safely pass text to pbcopy
                vim.fn.system('echo -n ' .. vim.fn.shellescape(text) .. ' | pbcopy')
                return lines
            end,
            ['*'] = function(lines)
                local text = table.concat(lines, '\n')
                vim.fn.system('echo -n ' .. vim.fn.shellescape(text) .. ' | pbcopy')
                return lines
            end,
        },
        paste = {
            ['+'] = function()
                local result = vim.fn.system('pbpaste')
                if result ~= '' then
                    -- Remove trailing newline that pbpaste adds
                    result = result:gsub('\n$', '')
                    return vim.split(result, '\n')
                end
                return {}
            end,
            ['*'] = function()
                local result = vim.fn.system('pbpaste')
                if result ~= '' then
                    result = result:gsub('\n$', '')
                    return vim.split(result, '\n')
                end
                return {}
            end,
        },
    }
end

-- ============================================
-- Docker OSC 52 Clipboard Provider
-- ============================================

local clipboard_cache = {
    last_copied = nil,
    last_copy_time = 0,
}

local function make_docker_clipboard_provider()
    local copy_func = function(lines)
        -- Join lines and encode to base64
        local text = table.concat(lines, '\n')

        -- Cache the copied text for fallback paste
        clipboard_cache.last_copied = text
        clipboard_cache.last_copy_time = vim.loop.now()

        -- Use base64 with -w 0 to prevent line wrapping
        local encoded = vim.fn.system('echo -n ' .. vim.fn.shellescape(text) .. ' | base64 -w 0')

        -- Remove any trailing whitespace from vim.fn.system output
        encoded = encoded:gsub('%s+$', '')

        -- Send OSC 52 sequence to terminal
        -- Format: OSC 52 ; c ; <base64> ST
        local osc52 = '\x1b]52;c;' .. encoded .. '\x07'

        -- Use Neovim's API to write directly to stdout
        vim.api.nvim_out_write(osc52)

        return lines
    end

    local paste_func = function()
        -- For Docker, try multiple approaches:
        -- 1. xclip (if X11 is set up)
        -- 2. pbpaste (shouldn't work but worth trying)
        -- 3. cached copy
        -- 4. unnamed register

        local result = vim.fn.system('xclip -selection clipboard -o 2>/dev/null')
        if result ~= '' and vim.fn.v.shell_error == 0 then
            result = result:gsub('\n$', '')
            return vim.split(result, '\n')
        end

        result = vim.fn.system('pbpaste 2>/dev/null')
        if result ~= '' and vim.fn.v.shell_error == 0 then
            result = result:gsub('\n$', '')
            return vim.split(result, '\n')
        end

        if clipboard_cache.last_copied and clipboard_cache.last_copied ~= '' then
            return vim.split(clipboard_cache.last_copied, '\n')
        end

        local reg_content = vim.fn.getreg('"')
        if reg_content ~= '' then
            return vim.split(reg_content, '\n')
        end

        return {}
    end

    return {
        name = 'OSC52',
        copy = {
            ['+'] = copy_func,
            ['*'] = copy_func,
        },
        paste = {
            ['+'] = paste_func,
            ['*'] = paste_func,
        },
    }
end

-- ============================================
-- Setup Clipboard Provider
-- ============================================

if IN_DOCKER then
    vim.g.clipboard = make_docker_clipboard_provider()
else
    vim.g.clipboard = make_macos_clipboard_provider()
end

-- Enable unnamedplus so y/p use system clipboard
vim.opt.clipboard = 'unnamedplus'
