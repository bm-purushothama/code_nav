local M = {}

function M.get_git_root()
  local git_dir = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 and git_dir then
    return git_dir
  else
    return vim.fn.getcwd()
  end
end

return M
