# lir-bookmark.nvim

## Installation

```
Plug 'tamago324/lir.nvim'
Plug 'tamago324/lir-bookmark.nvim'
Plug 'nvim-lua/plenary.nvim'
```

## Usage

Used in the `mappings` of `lir.setup()`

```lua
require'lir'.setup {
  -- ...
  mappings = {
    -- ...
    ['B']     = require'lir.bookmark.actions'.list,
    ['ba']     = require'lir.bookmark.actions'.add,
  },
}


local b_actions = require'lir.bookmark.actions'
require'lir.bookmark'.setup {
  bookmark_path = '~/.lir_bookmark',
  mappings = {
    ['l']     = b_actions.edit,
    ['<C-s>'] = b_actions.split,
    ['<C-v>'] = b_actions.vsplit,
    ['<C-t>'] = b_actions.tabedit,
    ['<C-e>'] = b_actions.open_lir,
    ['B']     = b_actions.open_lir,
    ['q']     = b_actions.open_lir,
  }
}
```


## License

MIT
