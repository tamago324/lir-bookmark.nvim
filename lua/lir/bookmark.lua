local config = require 'lir.bookmark.config'

local M = {}

function M.setup(prefs)
  -- Set preferences
  config.set_default_values(prefs)
end

return M
