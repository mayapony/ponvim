return {
  "mistricky/codesnap.nvim",
  build = "make",
  cmd = "CodeSnap",
  opts = {
    save_path = "~",
  },
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
  },
}
