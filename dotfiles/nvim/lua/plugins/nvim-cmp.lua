return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {"L3MON4D3/LuaSnip"},
    },
    config = function()

        local cmp = require("cmp")
        local cmp_select = {behaviour = cmp.SelectBehavior.Select}

        cmp.setup({

            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },

            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({select = true}),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-e>'] = cmp.mapping.abort(),
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }),

        })
    end
}
