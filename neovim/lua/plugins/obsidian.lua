-- obsidian.nvim configuration for the PKM-OS v1.0
-- This file should be placed in your Neovim configuration (e.g., lua/plugins/obsidian.lua)

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- Use the latest version
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- Your chosen picker
  },
  opts = {
    -- Define the single workspace for your vault.
    -- Using a relative path from your home directory (`~`) is standard.
    workspaces = {
      {
        name = "pkm-os",
        path = "~/Documents/Askr.Vault-2506",
      },
    },

    -- Configure how daily notes are handled.
    -- Paths are relative to your vault root for portability.
    daily_notes = {
      folder = "var/log/daily", -- CORRECTED: Aligned with v0.5 design.
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "etc/templates/tpl-daily-log.md", -- CORRECTED: Relative path.
    },

    -- Configure note templates.
    templates = {
      folder = "etc/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Optional: Configure autocompletion behavior.
    completion = {
      nvim_cmp = false, -- Set to true if you use nvim-cmp
      min_chars = 2,
    },

    -- Define the picker for searching notes, etc.
    picker = {
      name = "telescope.nvim",
    },

    -- Use [[wikilinks]] by default.
    preferred_link_style = "wiki",

    -- This function automatically generates a unique ID for new notes.
    -- This is the core of your "headless OS" naming strategy.
    note_id_func = function(title)
      -- If title is provided, it will be used as an alias.
      -- The filename will always be the UID.
      -- REVERTED: Timestamp format restored to your preference without seconds.
      return os.date("%Y%m%d%H%M")
    end,

    -- Optional: Customize UI elements like checkbox characters.
    ui = {
      enable = true,
      checkboxes = {
        -- Using common Nerd Font icons for checkboxes.
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" }, -- IMPROVED: Added a checkmark.
        [">"] = { char = "▶", hl_group = "ObsidianRightArrow" }, -- IMPROVED: Added a right arrow.
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "❗", hl_group = "ObsidianImportant" }, -- IMPROVED: Added an exclamation mark.
      },
    },

    -- Use a standard function to open web links.
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- `open` is the standard command on macOS.
    end,
  },
}
