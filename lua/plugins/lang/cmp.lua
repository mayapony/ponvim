local bufIsBig = function(bufnr)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats and stats.size > max_filesize then
    return true
  else
    return false
  end
end

return {
  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "BufReadPost",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
    },
    config = function()
      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
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
        { name = "codeium" },
      })

      vim.api.nvim_create_autocmd("BufReadPre", {
        callback = function(t)
          local sources = default_cmp_sources
          if not bufIsBig(t.buf) then
            sources[#sources + 1] = { name = "treesitter", group_index = 2 }
          end
          cmp.setup.buffer({
            sources = sources,
          })
        end,
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
        window = {
          documentation = {
            max_height = 15,
            max_width = 60,
          },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = require("lspkind").cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
            symbol_map = { Codeium = "" },
          }),
        },
      })
    end,
  },
}
