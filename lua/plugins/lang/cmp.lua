local function setup_cmp_highlight()
  local mocha = require("catppuccin.palettes").get_palette("mocha")

  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = mocha.pink, bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
end

local function setup_autocmds()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("cmp_gitmoji", { clear = true }),
    pattern = { "NeogitCommitMessage", "gitcommit" },
    callback = function()
      require("cmp").setup.buffer({
        sources = {
          { name = "gitmoji" },
        },
      })
    end,
  })
end

return {
  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "megalithic/cmp-gitmoji",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      setup_cmp_highlight()
      setup_autocmds()

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
        view = {
          entries = { name = "wildmenu", separator = "|" },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      local default_cmp_sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 1 },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 2 },
        { name = "path", keyword_length = 2 },
        { name = "nvim_lua", keyword_length = 2 },
        { name = "lazydev", group_index = 0 },
      })

      cmp.setup({
        sources = default_cmp_sources,
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end),
          ["<C-n>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {},
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            },
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
      })
    end,
  },
}
