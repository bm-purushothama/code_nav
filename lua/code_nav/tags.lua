local M = {}
local config = require("code_nav.config").settings
local util = require("code_nav.util")

function M.update_tags()
  local root = util.get_git_root()
  if vim.fn.executable("gtags") == 0 or vim.fn.executable("ctags") == 0 then
    vim.notify("gtags or ctags is not installed.", vim.log.levels.ERROR)
    return
  end
  vim.fn.jobstart({
    "sh", "-c", "ctags -R && gtags --gtagslabel=" .. config.gtags_label
  }, {
    cwd = root,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Tags updated successfully")
      else
        vim.notify("Failed to update tags", vim.log.levels.ERROR)
      end
    end
  })
end

return M
