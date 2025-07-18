-- obsidian.nvim configuration for PKM-OS v3.0
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
    workspaces = {
      {
        name = "askr-vault-2506",
        path = "~/Documents/askr-vault-2506/", -- Updated to new repo name
      },
    },
    -- Configure how daily notes are handled.
    daily_notes = {
      folder = "var/log", -- Simplified path structure
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "etc/templates/tpl-daily-log.md", -- Fixed template name
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
    -- Generate descriptive filenames instead of UIDs
    -- PKM-OS v3.0 uses human-readable names, not timestamps
    note_id_func = function(title)
      if title then
        -- Convert title to lowercase, replace spaces with hyphens
        return title:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
      else
        -- Fallback to timestamp if no title provided
        return os.date("%Y%m%d%H%M")
      end
    end,
    -- Enhanced UI for Tasks plugin compatibility
    ui = {
      enable = true,
      checkboxes = {
        -- Standard markdown checkboxes
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "✔", hl_group = "ObsidianDone" },
        -- Additional checkbox states for Tasks plugin
        [">"] = { char = "▶", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["!"] = { char = "❗", hl_group = "ObsidianImportant" },
        ["-"] = { char = "➖", hl_group = "ObsidianMinus" },
        ["/"] = { char = "❓", hl_group = "ObsidianQuestion" },
      },
      -- Highlight Tasks plugin emojis
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#ffcb6b" },
        ObsidianTilde = { bold = true, fg = "#c792ea" },
        ObsidianImportant = { bold = true, fg = "#ff5370" },
      },
    },
    -- Use a standard function to open web links.
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- `open` is the standard command on macOS.
    end,
    -- Configure mappings for PKM-OS workflow
    mappings = {
      -- Quick access to system files
      ["<leader>ot"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { desc = "Toggle checkbox" },
      },
      -- Open tasks overview
      ["<leader>oT"] = {
        action = function()
          vim.cmd("edit ~/Documents/askr-vault-2506/var/tasks.md")
        end,
        opts = { desc = "Open tasks overview" },
      },
      -- Open spool (inbox)
      ["<leader>os"] = {
        action = function()
          vim.cmd("edit ~/Documents/askr-vault-2506/var/spool.md")
        end,
        opts = { desc = "Open spool (inbox)" },
      },
      ["<leader>oo"] = {
        action = function()
          local path = vim.fn.expand("%:p")
          vim.fn.jobstart({ "open", "-a", "Obsidian", path })
        end,
        opts = { desc = "Open in Obsidian GUI" },
      },
    },
  },
}
