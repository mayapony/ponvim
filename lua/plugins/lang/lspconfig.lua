vim.diagnostic.config({
  virtual_text = {
    -- prefix = "👈🤣", -- Could be '●', '▎', 'x'
    prefix = "●", -- Could be '●', '▎', 'x'
    -- severity = {
    --   -- Specify a range of severities
    --   min = vim.diagnostic.severity.ERROR,
    -- },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
  },
})

local signs = { Error = " ", Warn = " ", Hint = "󰛨 ", Info = " " }
-- local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

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
      priority = 10000,
      cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      event = { "VeryLazy" },
    },
    { "nvim-telescope/telescope.nvim" },
    { "b0o/SchemaStore.nvim" },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = { lsp = { auto_attach = true } },
      keys = {
        { "<leader>ss", "<cmd>Navbuddy<cr>", desc = "Toggle navbuddy" },
      },
    },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      -- server name source: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
      ensure_installed = {
        -- Replace these with whatever servers you want to install
        "tsserver",
        "lua_ls",
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- To instead override globally
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  end,
  keys = {
    {
      "<leader>mm",
      "<cmd>Mason<cr>",
      desc = "Open Mason",
    },
  },
}
