return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Add telescope as a dependency since you're using it as picker
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    -- Single workspace (your vault)
    workspaces = {
      {
        name = "main",
        path = "~/Documents/Askr.Vault-2506",
      },
    },

    -- Daily notes configuration
    daily_notes = {
      folder = "02_Daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "10_Library/Templates/Template_Daily_Log.md",
    },

    -- Templates configuration
    templates = {
      folder = "10_Library/Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },

    -- Change this to a supported picker
    picker = {
      name = "telescope.nvim",
      -- Alternative options:
      -- name = "fzf-lua",
      -- name = "mini.pick",
    },

    preferred_link_style = "wiki",

    note_id_func = function(title)
      if title ~= nil then
        -- Replace spaces with hyphens, preserve German characters, convert to lowercase
        return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-_üäöÜÄÖß]", "")
      else
        return tostring(os.time())
      end
    end,

    ui = {
      enable = true,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
      },
    },

    follow_url_func = function(url)
      vim.ui.open(url)
    end,
  },
}
