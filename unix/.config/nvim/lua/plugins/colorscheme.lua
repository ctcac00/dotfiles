return {
  {
    "oxfist/night-owl.nvim",
    lazy = false, -- Make sure it loads on startup
    priority = 1000,
    config = function()
      -- Load the theme
      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")

      -- Override Highlights
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- #c792ea is the Night Owl Purple. Alternatively try #82aaff (Blue) or #addb67 (Green)
          vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#c792ea" })

          -- #405769 is a muted blue-grey that blends well with the Night Owl background
          vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#405769" })
        end,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "night-owl",
    },
  },
}
