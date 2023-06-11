{
  colorizer.enable = true;
  gitsigns.enable = true;
  lsp = import ./lsp.nix;
  lspkind.enable = true;
  lualine = import ./lualine.nix;
  luasnip = {
    enable = true;
    extraConfig = {update_events = "TextChanged,TextChangedI";};
  };
  null-ls = import ./null-ls.nix;
  nvim-cmp = import ./cmp.nix;
  rust-tools.enable = true;
  telescope = {
    enable = true;
  };
  treesitter = {
    enable = true;
    indent = true;
    incrementalSelection.enable = true;
  };
  treesitter-context.enable = true;
}
