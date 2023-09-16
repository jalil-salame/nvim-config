{
  colorizer.enable = true;
  gitsigns.enable = true;
  lspconfig = import ./lspconfig.nix;
  lspkind.enable = true;
  lspsaga.enable = true;
  lualine = import ./lualine.nix;
  luasnip.enable = true;
  luasnip.extraConfig = {update_events = "TextChanged,TextChangedI";};
  nvim-cmp = import ./cmp.nix;
  rust-tools.enable = true;
  # rust-tools.server.on_attach = import ./on_attach.nix;
  telescope.enable = true;
  treesitter.enable = true;
  treesitter.indent = true;
  treesitter.incrementalSelection.enable = true;
  treesitter-context.enable = true;
}
