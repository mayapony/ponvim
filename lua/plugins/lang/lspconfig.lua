return {
  "neovim/nvim-lspconfig",
  -- lazy load lspconfig
  -- source: https://www.reddit.com/r/neovim/comments/1308ie7/help_how_to_lazy_load_lspconfig/
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "williamboman/mason-lspconfig.nvim" },
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    },
    { "b0o/SchemaStore.nvim" },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        lsp = { auto_attach = true },
        window = {
          size = "90%",
          sections = {
            left = {
              size = "20%",
              border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
              size = "30%",
              border = nil,
            },
            right = {
              border = nil,
              preview = "leaf",
            },
          },
        },
      },
      keys = {
        { "<leader>to", "<cmd>Navbuddy<cr>", desc = "Toggle Navbuddy Outline" },
      },
    },
  },
  config = function()
    local ensure_installed = {
      "lua_ls",
      "tailwindcss",
      "kotlin_language_server",
      "bashls",
      "emmet_ls",
      "clangd",
    }
    require("mason").setup()
    require("mason-lspconfig").setup({
      -- server name source: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    for _, server in pairs(ensure_installed) do
      if server == "lua_ls" then
        lspconfig[server].setup({
          settings = {
            runtime = {
              version = "LuaJIT",
            },
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = {
                enable = false,
              },
            },
          },
        })
      else
        lspconfig[server].setup({})
      end
    end

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set(
      "n",
      "gh",
      vim.diagnostic.open_float,
      { noremap = true, silent = true, desc = "diagnostic open float" }
    )
    vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>CodeActionMenu<cr>", { desc = "code action menu" })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("maya-user-lsp-config", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = ev.buf, desc = "definitions" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = ev.buf, desc = "implementations" })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "rename" })
        vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = ev.buf, desc = "references" })
        vim.keymap.set("n", "go", builtin.lsp_document_symbols, { buffer = ev.buf, desc = "document symbols" })
        vim.keymap.set("n", "gh", vim.diagnostic.open_float, { noremap = true, silent = true })
        vim.keymap.set("n", "gx", builtin.diagnostics, { buffer = 0, desc = "diagnostics" })
        vim.keymap.set(
          "n",
          "gw",
          builtin.lsp_workspace_symbols,
          { noremap = true, silent = true, desc = "workspace symbols" }
        )
      end,
    })
  end,
  keys = {
    {
      "<leader>mm",
      "<cmd>Mason<cr>",
      desc = "Open Mason",
    },
  },
}
