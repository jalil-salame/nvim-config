{
  # Quickfix
  normal."<leader>qo" = {
    action = "'<cmd>Copen<CR>'";
    desc = "[Q]uickfix [O]pen";
  };
  normal."<leader>qq" = {
    action = "'<cmd>cclose<CR>'";
    desc = "[Q]uickfix [Q]uit";
  };
  normal."<leader>qj" = {
    action = "'<cmd>cnext<CR>'";
    desc = "[Q]uickfix Next [J]";
  };
  normal."<leader>qk" = {
    action = "'<cmd>cprev<CR>'";
    desc = "[Q]uickfix Previous [K]";
  };
  # Keep Selection when indenting
  visualOnly.">" = {
    action = "'>gv'";
    desc = "Indent Selection";
  };
  visualOnly."<" = {
    action = "'<gv'";
    desc = "Deindent Selection";
  };
  # Diagnostics
  normal."<leader>dj" = {
    action = "vim.diagnostic.goto_next";
    desc = "[D]iagnostics Next [J]";
  };
  normal."<leader>dk" = {
    action = "vim.diagnostic.goto_prev";
    desc = "[D]iagnostics Previous [K]";
  };
  # Telescope
  # normal."<leader>gf" = {
  #   action = "git_find_files";
  #   desc = "[G]it [F]iles";
  # };
  # normal."<leader>gg" = {
  #   action = "git_live_grep";
  #   desc = "[G]it [G]rep";
  # };
  normal."<leader>ff" = {
    action = "require('telescope.builtin').find_files";
    desc = "[F]ind [F]iles";
  };
  normal."<leader>fg" = {
    action = "require('telescope.builtin').live_grep";
    desc = "[F]ind [G]rep";
  };
  normal."<leader>fh" = {
    action = "require('telescope.builtin').help_tags";
    desc = "[F]ind [H]elp";
  };
  normal."<leader>fb" = {
    action = "require('telescope.builtin').buffers";
    desc = "[F]ind [B]uffer";
  };
  normal."<leader>fd" = {
    action = "require('telescope.builtin').diagnostics";
    desc = "[F]ind [D]iagnostics";
  };
  normal."<leader>fq" = {
    action = "require('telescope.builtin').quickfix";
    desc = "[F]ind [Q]uickfix";
  };
}
