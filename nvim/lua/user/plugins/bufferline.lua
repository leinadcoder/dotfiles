-- Display buffers as tabs.

local inactiveBg = {
  bg = {
    attribute = 'bg',
    highlight = 'BufferlineInactive',
  },
}

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
}
