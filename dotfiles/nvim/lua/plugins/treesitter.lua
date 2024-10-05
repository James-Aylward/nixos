return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "python",
                "latex",
                "json",
                "lua",
                "rust",
                "cpp",
            },
            highlight= {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

        })
    end
}
