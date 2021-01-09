local config = {}
config.values = {}

local defaults_values = {
  bookmark_path = '~/.lir_bookmark',
  mappings = {},
}

function config.set_default_values(opts)
  config.values = vim.tbl_deep_extend('force', defaults_values, opts or {})
end

return config

