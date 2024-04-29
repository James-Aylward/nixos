return  {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        lsp.clangd.setup{}
        lsp.lua_ls.setup{}
	lsp.rust_analyzer.setup{}
    end
}
