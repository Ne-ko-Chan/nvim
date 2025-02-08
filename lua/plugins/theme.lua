return {
  "folke/tokyonight.nvim",
  -- 'kooparse/vim-color-desert-night',
  -- "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd("colorscheme tokyonight-storm")
    -- vim.cmd("colorscheme everforest")
  end,
}
