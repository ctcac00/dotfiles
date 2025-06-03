return {
  "folke/noice.nvim",
  opts = {
    presets = {
      lsp_doc_border = true,
      long_message_to_split = false,
      bottom_search = false,
      command_palette = false,
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      view = "mini", -- default view for messages
      view_error = "mini", -- view for errors
      view_warn = "mini", -- view for warnings
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
      view = "mini",
    },
    lsp = {
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "mini",
      },
    },
  },
}
