local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local config = require("code_nav.config").settings

local M = {}

function M.run_picker(cmd, args, title)
  pickers.new({}, {
    prompt_title = title,
    finder = finders.new_oneshot_job(vim.list_extend({cmd}, args), {}),
    previewer = config.preview_window and conf.file_previewer({}) or nil,
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local filepath, lnum = entry[1]:match("([^:]+):(%d+)")
        if filepath and lnum then
          vim.cmd(string.format("e +%s %s", lnum, filepath))
        end
      end)
      return true
    end,
  }):find()
end

function M.hover_preview()
  local word = vim.fn.expand("<cword>")
  if not word or word == "" then
    vim.notify("No symbol under cursor", vim.log.levels.INFO)
    return
  end
  local output = vim.fn.systemlist({"global", "-x", word})
  if vim.v.shell_error ~= 0 or not output or #output == 0 then
    vim.notify("No results from gtags", vim.log.levels.INFO)
    return
  end
  local float_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, output)
  local width = math.max(40, math.floor(vim.o.columns * 0.5))
  local height = math.min(10, #output)
  local float_win = vim.api.nvim_open_win(float_buf, true, {
    relative = "cursor",
    width = width,
    height = height,
    col = 1,
    row = 1,
    style = "minimal",
    border = "rounded",
  })
end

return M
