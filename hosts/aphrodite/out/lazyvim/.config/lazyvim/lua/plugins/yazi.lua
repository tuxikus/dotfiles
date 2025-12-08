return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    { "<leader>fy", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Yazi at the current file" },
    { "<leader>fY", "<cmd>Yazi cwd<cr>", desc = "Yazi at vim root" },
    -- { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session" },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
