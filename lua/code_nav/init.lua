local M = {}

M.config = require("code_nav.config")
M.tags = require("code_nav.tags")
M.search = require("code_nav.search")
M.ui = require("code_nav.ui")
M.util = require("code_nav.util")

-- User Commands
vim.api.nvim_create_user_command("GTagsDefs", function(opts)
  M.search.gtags_defs(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("GTagsRefs", function(opts)
  M.search.gtags_refs(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("CodeGrep", function(opts)
  M.search.code_grep(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("CodeFiles", function()
  M.search.find_files()
end, {})

vim.api.nvim_create_user_command("GTagsUpdate", function()
  M.tags.update_tags()
end, {})

vim.api.nvim_create_user_command("CodeNavHover", function()
  M.ui.hover_preview()
end, {})

return M
