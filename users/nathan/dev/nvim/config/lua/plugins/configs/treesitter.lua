local parser_install_dir = vim.fn.expand("$HOME/.nix-profile/parser/");
vim.opt.runtimepath:append(parser_install_dir)

local options = {
  parser_install_dir = parser_install_dir,
  ensure_installed = {},
  auto_install = false,
  highlight = {
    enable = true;
  };
}

return options;
