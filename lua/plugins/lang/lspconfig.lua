return {
  "neovim/nvim-lspconfig",
  -- lazy load lspconfig
  -- source: https://www.reddit.com/r/neovim/comments/1308ie7/help_how_to_lazy_load_lspconfig/
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    },
    { "b0o/SchemaStore.nvim" },
  },
  config = function()
    local ensure_installed = {
      "lua_ls",
      "tailwindcss",
      "bashls",
      -- "tsserver",
      -- "eslint"
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      -- server name source: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      ensure_installed = ensure_installed,
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local lsp_opts = require("config.lsp")

    for _, server in pairs(ensure_installed) do
      if server == "eslint" then
        lspconfig[server].setup(lsp_opts.eslint)
      else
        lspconfig[server].setup({})
      end
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("maya-user-lsp-config", {}),
      callback = function(ev)
        require("config.lsp").lsp_attach_callback(ev.buf)
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
