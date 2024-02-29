return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      --Kemaps
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<F5>", dap.continue, {})
      vim.keymap.set("n", "<F10>", function()
        dap.step_over()
      end)
      vim.keymap.set("n", "<F11>", function()
        dap.step_into()
      end)
      vim.keymap.set("n", "<F12>", function()
        dap.step_out()
      end)

      --dapui setup
      require("dapui").setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      --gdb configuration for c, cpp, rust
      dap.adapters.gdb = {
        id = "gdb",
        type = "executable",
        command = "gdb",
        args = { "--quiet", "--interpreter=dap" },
      }

      dap.configurations.cpp = {
        {
          name = "Run executable (GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            local path = vim.fn.input({
              prompt = "Path to executable: ",
              default = vim.fn.getcwd() .. "/",
              completion = "file",
            })

            return (path and path ~= "") and path or dap.ABORT
          end,
        },
      }
    end,
  },
}
