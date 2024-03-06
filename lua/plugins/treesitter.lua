return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "css" },
      auto_install = true,
      ignore_install = { "tex", "latex" },
      highlight = { enable = true, disable = { "tex", "latex" } },
      indent = { enable = true },
    })
  end,
}
