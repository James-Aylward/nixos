return {
    {
        "chentoast/marks.nvim",
        config = function ()
            require('marks').setup({
                signs = true,
                builtin_marks = { ".", "<", ">", "^" },
                default_mappings = true,
            })
        end
    }
}
