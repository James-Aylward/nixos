return  {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        lsp.clangd.setup{}
        lsp.lua_ls.setup{}
        lsp.rust_analyzer.setup{}
        lsp.texlab.setup{}
        lsp.svelte.setup{}
        lsp.pyright.setup{}
        lsp.nixd.setup({
            cmd = { "nixd" },
            settings = {
                nixd = {
                    nixpkgs = {
                        expr = "import <nixpkgs> { }",
                    },
                    formatting = {
                        command = { "nixpkgs-fmt" }, -- or nixfmt or nixpkgs-fmt
                    },
                    options = {
                        nixos = {
                            expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.laptop.options',
                        },
                        --home_manager = {
                        --    expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
                        --},
                    },
                },
            },
        })
    end
}
