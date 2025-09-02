return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        bind_to_cwd = false, -- don’t automatically re-root on :cd
        follow_current_file = { enabled = true },
      },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none",
        },
      },
    },
  },
}
