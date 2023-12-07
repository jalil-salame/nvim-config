{
  colorizer.enable = true;
  colorizer.userDefaultOptions.names = false; # disable named colors (i.e. red)
  gitsigns.enable = true;
  lspconfig = import ./lspconfig.nix;
  lspkind.enable = true;
  lspsaga.enable = true;
  lspsaga.extraConfig = {lightbulb = {sign = false;};}; # do not show in sign column
  lualine = import ./lualine.nix;
  luasnip.enable = true;
  luasnip.extraConfig = {update_events = "TextChanged,TextChangedI";};
  nvim-cmp = import ./cmp.nix;
  rust-tools.enable = true;
  telescope.enable = true;
  treesitter.enable = true;
  treesitter.indent = true;
  treesitter.incrementalSelection.enable = true;
  treesitter-context.enable = true;
}
