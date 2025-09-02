-- File: ~/.config/nvim/lua/actions.lua
local M = {}

function M.create_action(template)
  local action = vim.fn.input("Action: ")
  if action == "" then
    return
  end

  local today = os.date("%Y-%m-%d")
  local line = ""

  if template == "basic" then
    line = "- [ ] #action " .. action
  elseif template == "created" then
    line = "- [ ] #action " .. action .. " ➕ " .. today
  elseif template == "scheduled" then
    local date = vim.fn.input("Scheduled date (YYYY-MM-DD): ")
    if date == "" then
      date = today
    end
    line = "- [ ] #action " .. action .. " ⏳ " .. date
  elseif template == "start" then
    local date = vim.fn.input("Start date (YYYY-MM-DD): ")
    if date == "" then
      date = today
    end
    line = "- [ ] #action " .. action .. " 🛫 " .. date
  elseif template == "due" then
    local date = vim.fn.input("Due date (YYYY-MM-DD): ")
    if date == "" then
      date = today
    end
    line = "- [ ] #action " .. action .. " 📅 " .. date
  elseif template == "high" then
    line = "- [ ] #action " .. action .. " ⏫"
  elseif template == "low" then
    line = "- [ ] #action " .. action .. " 🔽"
  else
    line = "- [ ] #action " .. action
  end

  vim.api.nvim_put({ line }, "l", true, true)
end

function M.setup()
  vim.keymap.set("n", "<leader>aa", function()
    M.create_action("basic")
  end)
  vim.keymap.set("n", "<leader>ac", function()
    M.create_action("created")
  end)
  vim.keymap.set("n", "<leader>as", function()
    M.create_action("scheduled")
  end)
  vim.keymap.set("n", "<leader>aS", function()
    M.create_action("start")
  end)
  vim.keymap.set("n", "<leader>ad", function()
    M.create_action("due")
  end)
  vim.keymap.set("n", "<leader>ah", function()
    M.create_action("high")
  end)
  vim.keymap.set("n", "<leader>al", function()
    M.create_action("low")
  end)

  -- Complete/Cancel actions
  vim.keymap.set("n", "<leader>ax", "^f]r✅A ✅ <C-r>=strftime('%Y-%m-%d')<CR><Esc>")
  vim.keymap.set("n", "<leader>aX", "^f]r❌A ❌ <C-r>=strftime('%Y-%m-%d')<CR><Esc>")
end

return M
