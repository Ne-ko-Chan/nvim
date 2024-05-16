return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
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
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      require("dap-go").setup({
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = "dlv",
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port
          port = "${port}",
          -- additional args to pass to dlv
          args = {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          build_flags = "",
          -- whether the dlv process to be created detached or not. there is
          -- an issue on Windows where this needs to be set to false
          -- otherwise the dlv server creation will fail.
          detached = true,
        },
      })
    end,
  },
}
