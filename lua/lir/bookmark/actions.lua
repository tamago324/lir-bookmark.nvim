local a = vim.api

local Path = require 'plenary.path'
local actions = require 'lir.actions'
local lir = require 'lir'
local lir_float = require 'lir.float'
local mappings = require 'lir.bookmark.mappings'
local config = require 'lir.bookmark.config'

local M = {}

local function highlight(files)
  local ns = vim.api.nvim_create_namespace('lir_mmv_dir')
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  for i, file in ipairs(files) do
    if Path:new(file):is_dir() then
      vim.api.nvim_buf_add_highlight(0, ns, 'PreProc', i - 1, 0, -1)
    end
  end
end

-- Use from lir.nvim
function M.list(context)
  local bookmark_path = config.values.bookmark_path
  vim.w.lir_dir = context.dir
  vim.cmd('keepalt edit ' .. bookmark_path)
  highlight(Path:new(bookmark_path):readlines())
  mappings.apply_mappings(config.values.mappings)
end


-- Use from lir.nvim
function M.add(context)
  -- flags: https://nodejs.org/api/fs.html#fs_file_system_flags
  -- a+ : read/write (append). Also, if it does not exists, create it.
  local path = context.dir .. context:current_value()
  local bookmark_path = config.values.bookmark_path
  assert(uv.fs_open(bookmark_path, "a+", 438, function(err, fd)
    uv.fs_write(fd, path .. '\n', -1)
    uv.fs_close(fd)
    print('[lir-bookmark] Added bookmark: ' .. path)
  end))
end



local function open(cmd)
  local path = vim.fn.fnameescape(a.nvim_get_current_line())
  actions.quit()
  vim.cmd(cmd .. ' ' .. path)
end

--- split
function M.split()
  open('new')
end

--- vsplit
function M.vsplit()
  open('vnew')
end

--- tabedit
function M.tabedit()
  open('tabedit')
end

--- edit
function M.edit()
  local path = a.nvim_get_current_line()
  if vim.w.lir_is_float and not Path:new(path):is_dir() then
    -- 閉じてから開く
    actions.quit()
  end

  vim.cmd('keepalt edit ' .. vim.fn.fnameescape(path))
end

function M.open_lir()
  if vim.w.lir_is_float then
    actions.quit()
    lir_float.init(vim.w.lir_dir)
  else
    vim.cmd('edit ' .. vim.w.lir_dir)
    vim.cmd('doautocmd BufEnter')
    pcall(a.nvim_win_del_var, {0, 'lir_dir'})
  end
end


return M
