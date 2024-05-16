return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        --Lua
        null_ls.builtins.formatting.stylua,

        --JS
        --null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.prettier,

        --C++
        null_ls.builtins.formatting.clang_format,

        --Go
        null_ls.builtins.formatting.golines,

        --Python
        null_ls.builtins.formatting.black,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
