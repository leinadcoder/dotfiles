return {
  {
    "shaunsingh/nord.nvim",
    lazy = false, -- make sure we load this during startup if it is your main color scheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the color scheme here
      vim.cmd([[colorscheme nord]])
    end,
  },
}
