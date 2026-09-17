local M = {}

M.general = {
  t = {
    ["<C-h>"] = { "<C-\\><C-n><C-w>h", "Window left" },
    ["<C-l>"] = { "<C-\\><C-n><C-w>l", "Window right" },
    ["<C-j>"] = { "<C-\\><C-n><C-w>j", "Window down" },
    ["<C-k>"] = { "<C-\\><C-n><C-w>k", "Window up" },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Adiciona JSON struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Adiciona YAML struct tags",
    },
    ["<leader>gsr"] = {
      "<cmd> GoTagRm json <CR>",
      "Remove JSON struct tags",
    },
    ["<leader>gie"] = {
      "<cmd> GoIfErr <CR>",
      "Insere bloco if err != nil",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Adiciona/remove breakpoint",
    },
    ["<leader>dc"] = {
      "<cmd> DapContinue <CR>",
      "Continuar/iniciar debug",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Abre sidebar de debug",
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug teste Go (func de baixo do cursor)",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug último teste Go executado",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "Debug teste Python (método de baixo do cursor)",
    },
  },
}

return M
