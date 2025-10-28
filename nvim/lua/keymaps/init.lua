-- ============================================
-- Basic Keymaps
-- ============================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================
-- General
-- ============================================

-- Better save
keymap("n", "<C-s>", "<cmd>w<cr>", vim.tbl_extend("force", opts, { desc = "Save file" }))
keymap("i", "<C-s>", "<Esc><cmd>w<cr>a", vim.tbl_extend("force", opts, { desc = "Save file" }))

-- Quit
keymap("n", "<leader>q", "<cmd>q<cr>", vim.tbl_extend("force", opts, { desc = "Quit" }))
keymap("n", "<leader>Q", "<cmd>qa!<cr>", vim.tbl_extend("force", opts, { desc = "Quit all" }))

-- Better escape
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- Clear search highlighting
keymap("n", "<Esc>", "<cmd>nohlsearch<cr>", opts)

-- ============================================
-- Navigation
-- ============================================

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", vim.tbl_extend("force", opts, { desc = "Go to left window" }))
keymap("n", "<C-j>", "<C-w>j", vim.tbl_extend("force", opts, { desc = "Go to lower window" }))
keymap("n", "<C-k>", "<C-w>k", vim.tbl_extend("force", opts, { desc = "Go to upper window" }))
keymap("n", "<C-l>", "<C-w>l", vim.tbl_extend("force", opts, { desc = "Go to right window" }))

-- Resize windows
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", vim.tbl_extend("force", opts, { desc = "Increase window height" }))
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", vim.tbl_extend("force", opts, { desc = "Decrease window height" }))
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", vim.tbl_extend("force", opts, { desc = "Decrease window width" }))
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", vim.tbl_extend("force", opts, { desc = "Increase window width" }))

-- ============================================
-- Splits
-- ============================================

keymap("n", "<leader>sv", "<cmd>vsplit<cr>", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
keymap("n", "<leader>sh", "<cmd>split<cr>", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
keymap("n", "<leader>se", "<C-w>=", vim.tbl_extend("force", opts, { desc = "Make splits equal size" }))
keymap("n", "<leader>sx", "<cmd>close<cr>", vim.tbl_extend("force", opts, { desc = "Close current split" }))

-- ============================================
-- Tabs
-- ============================================

keymap("n", "<leader>tn", "<cmd>tabnew<cr>", vim.tbl_extend("force", opts, { desc = "Open new tab" }))
keymap("n", "<leader>tc", "<cmd>tabclose<cr>", vim.tbl_extend("force", opts, { desc = "Close current tab" }))
keymap("n", "<leader>to", "<cmd>tabonly<cr>", vim.tbl_extend("force", opts, { desc = "Close other tabs" }))
keymap("n", "gt", "<cmd>tabnext<cr>", vim.tbl_extend("force", opts, { desc = "Go to next tab" }))
keymap("n", "gT", "<cmd>tabprevious<cr>", vim.tbl_extend("force", opts, { desc = "Go to previous tab" }))

-- ============================================
-- Text Editing
-- ============================================

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", opts)

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste without yanking
keymap("x", "<leader>p", '"_dP', vim.tbl_extend("force", opts, { desc = "Paste without yanking" }))

-- Delete without yanking
keymap({ "n", "v" }, "<leader>d", '"_d', vim.tbl_extend("force", opts, { desc = "Delete without yanking" }))

-- ============================================
-- Clipboard
-- ============================================

-- Standard Vim copy/paste with system clipboard
-- y = copy to clipboard (with clipboard=unnamedplus)
-- p = paste from clipboard
-- These work normally like in any Vim installation

-- ============================================
-- Command Mode
-- ============================================

-- Better command history navigation
keymap("c", "<C-j>", "<Down>", { noremap = true })
keymap("c", "<C-k>", "<Up>", { noremap = true })
