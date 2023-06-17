local spec = {
  "akinsho/bufferline.nvim",
	priority = 10000,
  event = "BufWinEnter",
  keys = {
    {
      "<S-h>",
      "<cmd>BufferLineCyclePrev<cr>",
      { desc = "Prev buffer" },
    },
    {
      "<S-l>",
      "<cmd>BufferLineCycleNext<cr>",
      { desc = "Next buffer" },
    },
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>ft", "<Cmd>BufferLinePick<CR>", desc = "Find Buffer" },
    {
      "<A-1>",
      mode = { "n", "i" },
      "<Cmd>BufferLineGoToBuffer 1<CR>",
      desc = "go to buffer 1",
    },
    {
      "<A-2>",
      mode = { "n", "i" },
      "<Cmd>BufferLineGoToBuffer 2<CR>",
      desc = "go to buffer 2",
    },
    {
      "<A-3>",
      mode = { "n", "i" },
      "<Cmd>BufferLineGoToBuffer 3<CR>",
      desc = "go to buffer 3",
    },
    {
      "<A-4>",
      mode = { "n", "i" },
      "<Cmd>BufferLineGoToBuffer 4<CR>",
      desc = "go to buffer 4",
    },
    {
      "<A-5>",
      mode = { "n", "i" },
      "<Cmd>BufferLineGoToBuffer 5<CR>",
      desc = "go to buffer 5",
    },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      themable = true,
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explore",
          highlight = "Directory",
          text_align = "left",
        },
      },
      buffer_close_icon = "",
      separator_style = { "", "" },
      extensions = { "lazy", "neo-tree", "nvim-dap-ui", "overseer", "symbols-outline", "toggleterm", "trouble" },
    },
  },
}

return spec
