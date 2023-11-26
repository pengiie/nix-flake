local options = {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-y>",
      accept_word = false,
      accept_line = false,
    },
  },
  filetypes = {
    lua = true,
  },
}

return options


