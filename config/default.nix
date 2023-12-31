{pkgs, ...}: {
  programs.nixneovim = {
    enable = true;
    package = pkgs.neovim-nightly;
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
    augroups = import ./augroups.nix;
    extraPlugins = builtins.attrValues {
      inherit (pkgs.vimExtraPlugins) nvim-config-local dressing-nvim rustaceanvim;
      inherit (pkgs.vimPlugins) lualine-lsp-progress nvim-web-devicons FTerm-nvim cmp-cmdline;
      inherit (pkgs.vimPlugins) formatter-nvim;
    };
    # Formatting
    extraPackages = builtins.attrValues {
      # Formatters
      inherit (pkgs) stylua shfmt taplo yamlfmt alejandra;
    };
    extraLuaPreConfig = ''
      -- Lua Pre Config
      if vim.fn.has 'termguicolors' then
        -- Enable RGB colors
        vim.g.termguicolors = true
      end

      -- Useful function
      local has_words_before = function()
        -- unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end
      -- END: Lua Pre Config
    '';
    extraLuaPostConfig = ''
      -- Lua Post Config
      do -- Setup config-local
        require('config-local').setup()
      end

      do -- Setup dressing.nvim
        -- require("dressing").setup()
      end

      do -- Setup cmp-cmdline
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

      do -- Setup formatter.nvim
        -- local util = require "formatter.util"
        require("formatter").setup {
          logging = true,
          log_level = vim.log.levels.WARN,
          ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
          -- Filetype Formatting
          c = { require("formatter.filetypes.c").clangformat },
          sh = { require("formatter.filetypes.sh").shfmt },
          cpp = { require("formatter.filetypes.cpp").clangformat },
          lua = { require("formatter.filetypes.lua").stylua },
          nix = { require("formatter.filetypes.nix").alejandra },
          zig = { require("formatter.filetypes.zig").zigfmt },
          rust = { require("formatter.filetypes.rust").rustfmt },
          toml = { require("formatter.filetypes.toml").taplo },
          yaml = { require("formatter.filetypes.yaml").yamlfmt },
        }
      end
    '';
  };
}
