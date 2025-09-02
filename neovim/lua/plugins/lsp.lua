-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    require("lspconfig").markdown_oxide.setup({
      capabilities = vim.tbl_deep_extend("force", capabilities, {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      }),
      root_dir = require("lspconfig").util.root_pattern(".obsidian", ".git"),
      single_file_support = false,
    })

    -- Optional: Add daily note command for markdown_oxide
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("obsidian_lsp", { clear = true }),
      pattern = "*.md",
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "markdown_oxide" then
          vim.api.nvim_create_user_command("Daily", function(cmd_args)
            local input = cmd_args.args
            vim.lsp.buf.execute_command({
              command = "jump",
              arguments = { input },
            })
          end, { desc = "Open daily note", nargs = "*" })
        end
      end,
    })
  end,
}
