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

      local default_cmp_sources = cmp.config.sources({
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer", keyword_length = 2 },
        { name = "path", keyword_length = 2 },
        { name = "nvim_lua", keyword_length = 2 },
      })

      local bufIsBig = function(bufnr)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
          return true
        else
          return false
        end
      end

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

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
        },
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
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          }),
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
		-- lazy load lspconfig
		-- source: https://www.reddit.com/r/neovim/comments/1308ie7/help_how_to_lazy_load_lspconfig/
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "williamboman/mason.nvim" },
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
    end,
    keys = {
      {
        "<leader>cm",
        "<cmd>Mason<cr>",
        desc = "Open Mason",
      },
    },
  },

  ---------------------------------
  -- null-ls ----------------------
  -- ------------------------------
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Replace these with the tools you have installed
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.stylua,
        },

        -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#sync-formatting
        -- 保存时异步格式化
        on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                require("config.function").async_formatting(bufnr)
              end,
            })
          end
        end,
      })
    end,
  },
  ---------------------------------
  -- null-ls ----------------------
  -- ------------------------------

  -- luasnip
  {
    "L3MON4D3/LuaSnip",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    config = function()
      local luasnip = require("luasnip")

      -- forget the current snippet when leaving the insert mode
      -- source: https://github.com/L3MON4D3/LuaSnip/issues/656
      local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })

      vim.api.nvim_create_autocmd("ModeChanged", {
        group = unlinkgrp,
        pattern = { "s:n", "i:*" },
        desc = "Forget the current snippet when leaving the insert mode",
        callback = function(evt)
          if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
            luasnip.unlink_current()
          end
        end,
      })
    end,
  },
}
