-- Display buffers as tabs.

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      themable = true,
      indicator = {
        style = 'underline'
      },
      buffer_close_icon = ' ',
      show_close_icon = false,
      show_tab_indicators = true,
      show_buffers_icons = true,
      show_buffer_close_icons = true,
      numbers = "ordinal",
      color_icons = true,
      separator_style = 'slant',
    }
  }
}
