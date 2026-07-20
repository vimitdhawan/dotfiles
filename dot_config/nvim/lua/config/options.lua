-- Custom options (loaded after LazyVim defaults)
local opt = vim.opt

opt.scrolloff = 8           -- Lines of context above/below cursor
opt.sidescrolloff = 8
opt.wrap = false            -- Don't wrap lines
opt.spelllang = { "en" }

-- Match IdeaVim feel
opt.relativenumber = true
opt.number = true
opt.signcolumn = "yes"
opt.cursorline = true
