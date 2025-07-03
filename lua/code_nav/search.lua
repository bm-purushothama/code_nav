local M = {}
local ui = require("code_nav.ui")
local util = require("code_nav.util")

function M.gtags_defs(symbol)
  if symbol == nil or symbol == "" then
    vim.notify("No symbol provided", vim.log.levels.WARN)
    return
  end
  ui.run_picker("global", {"-x", symbol}, "Definitions")
end

function M.gtags_refs(symbol)
  if symbol == nil or symbol == "" then
    vim.notify("No symbol provided", vim.log.levels.WARN)
    return
  end
  ui.run_picker("global", {"-rx", symbol}, "References")
end

function M.code_grep(pattern)
  if pattern == nil or pattern == "" then
    vim.notify("No search pattern provided", vim.log.levels.WARN)
    return
  end
  ui.run_picker("rg", {"--vimgrep", pattern}, "Grep")
end

function M.find_files()
  ui.run_picker("fd", {}, "Files")
end

return M
