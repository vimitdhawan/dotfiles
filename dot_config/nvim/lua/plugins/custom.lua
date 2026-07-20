-- Custom plugin overrides and additions
-- Add your own plugins here. LazyVim will merge them with its defaults.

return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        gitsigns = true,
        mini = true,
        telescope = { enabled = true },
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Disable plugins you don't want (example)
  -- { "plugin-name", enabled = false },
}
