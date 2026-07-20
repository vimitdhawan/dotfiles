-- ~/.config/nvim/init.lua — managed by chezmoi
-- Bootstrap LazyVim: https://www.lazyvim.org/

-- Bootstrap lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load LazyVim
require("lazy").setup({
  spec = {
    -- LazyVim core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- ── Language support ───────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.toml" },

    -- ── Editor enhancements ────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.editor.mini-files" },

    -- ── Formatting ─────────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.formatting.prettier" },

    -- ── DAP (Debug Adapter Protocol) ───────────────────────────────────
    { import = "lazyvim.plugins.extras.dap.core" },

    -- ── AI ──────────────────────────────────────────────────────────────
    -- Uncomment when you want AI completion in Neovim:
    -- { import = "lazyvim.plugins.extras.ai.copilot" },

    -- ── Your custom plugins go in lua/plugins/ ─────────────────────────
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
