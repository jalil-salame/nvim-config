{
  enable = true;
  servers.bashls.enable = true;
  servers.clangd.enable = true;
  servers.html.enable = true;
  servers.lua-language-server.enable = true;
  servers.jsonls.enable = true;
  servers.nil.enable = true;
  servers.pyright.enable = true;
  servers.rnix-lsp.enable = true;
  servers.ruff-lsp.enable = true;
  # servers.rust-analyzer.enable = true;
  # servers.serve_d.enable = true;
  # servers.statix.enable = true;
  servers.taplo.enable = true;
  servers.typst-lsp.enable = true;
  # servers.vimls.enable = true;
  onAttach = let
    opts = "noremap = true, buffer = bufnr";
  in ''
    local lsp_ui = require("LspUI").api

    -- Configure Omnifunc
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Keymaps
    vim.keymap.set('n', 'K', lsp_ui.api.hover, { desc = 'Hover Documentation', ${opts} })
    vim.keymap.set('n', '<leader>r', lsp_ui.api.rename, { desc = '[R]ename', ${opts} })
    vim.keymap.set({ 'n', 'v' }, '<leader>fa', lsp_ui.api.code_action, { desc = '[F]ind Code [A]ctions', ${opts} })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [D]efinition', ${opts} })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = '[G]o to [T]ype Definition', ${opts} })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]o to [I]mplementation', ${opts} })
     -- Formatting support
     if client.supports_method 'textDocument/formatting' then
      vim.keymap.set('n', '<leader>w', function() vim.lsp.buf.format { async = true } end, { desc = 'Format Buffer', ${opts} })
    else
      vim.keymap.set('n', '<leader>w', function() print 'Formating not supported for this language' end, { desc = '[Not Supported for filetype] Format Buffer', ${opts} })
    end
  '';
}
