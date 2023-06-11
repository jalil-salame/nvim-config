{pkgs, ...}: {
  programs.nixneovim = {
    enable = true;
    defaultEditor = true;
    colorschemes.gruvbox-nvim = {
      enable = true;
      bold = true;
      transparentBg = true;
      trueColor = true;
    };
    globals.mapleader = " ";
    options = import ./options.nix;
    plugins = import ./plugins;
    mappings = import ./mappings.nix;
    extraPlugins = builtins.attrValues {
      inherit (pkgs.vimPlugins) lualine-lsp-progress nvim-web-devicons FTerm-nvim cmp-cmdline;
    };
    extraLuaPreConfig = ''

      if vim.fn.has 'termguicolors' then
        vim.g.termguicolors = true
      end


      local has_words_before = function()
        -- unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end
    '';
    extraLuaPostConfig = ''

      do
        local cmp = require "cmp"
        cmp.setup.cmdline("/", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources { {name = "rg" }, { name = "buffer" } },
        })
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
        })
      end
    '';
  };
}
