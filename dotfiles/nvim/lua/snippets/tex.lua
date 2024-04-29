local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
    -- Table
    s(
        {
            trig="t",
            descr="Expands into table",
        },
        fmta(
            [[
                \begin{table}[h]
                    \centering
                    \begin{tabular}{ <> }
                    \hline
                    <> \\ \hline \hline
                    <> \\ \hline
                    \end{tabular}
                    \caption{<>}
                    \label{tab:<>}
                \end{table}
            ]],
            {
                i(1, " |c|c| "),
                i(2),
                i(3),
                i(4),
                i(5),
            }
        )
    ),
    -- Inline math
    s(
        {
            trig="im",
            descr="Expands into inline math",
        },
        fmta(
            "$<>$ <>",
            {
                i(1),
                i(0),
            }
        )
    ),
    -- Fractions
    s(
        {
            trig="ff",
            descr="Expands a fraction",
        },
        fmta(
            "\\frac{<>}{<>}",
            {
                i(1),
                i(2),
            }
        )
    ),
    -- Math Superscript
    s(
        {
            trig="*",
            descr="Expands a superscript",
        },
        fmta(
            "^{<>}<>",
            {
                i(1),
                i(0),
            }
        )
    ),
    -- Math Subscript
    s(
        {
            trig="_",
            descr="Expands a subscript",
        },
        fmta(
            "_{<>}<>",
            {
                i(1),
                i(0),
            }
        )
    ),
    -- Align environment
    s(
        {
            trig="am",
            descr="Aligned math",
        },
        fmta(
            [[
                \begin{align}
                    <>
                \end{align}
            ]],
            {
                i(1),
            }
        )
    ),
    -- Math aligned line
    s(
        {
            trig="al",
            descr="Creates a singular aligned line",
        },
        fmta(
            "<> &= <> \\\\<>",
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),
    -- Enumerate
    s(
        {
            trig="e",
            descr="Enumerate",
        },
        fmta(
            [[
                \begin{enumerate}
                    \item <>
                \end{enumerate}
            ]],
            {
                i(1),
            }
        )
    ),
    -- Itemize
    s(
        {
            trig="i",
            descr="Itemize",
        },
        fmta(
            [[
                \begin{itemize}
                    \item <>
                \end{itemize}
            ]],
            {
                i(1),
            }
        )
    ),
    -- Italicize
    s(
        {
            trig="it",
            descr="Italicize",
        },
        fmta(
            "\\textit{<>} <>",
            {
                i(1),
                i(0),
            }
        )
    ),
    -- Bold
    s(
        {
            trig="bf",
            descr="Bold",
        },
        fmta(
            "\\textbf{<>} <>",
            {
                i(1),
                i(0),
            }
        )
    ),
    -- Environment
    s(
        {
            trig="env",
            descr="Create an environment",
        },
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {
                i(1),
                i(0),
                r(1)
            }
        )
    ),
    -- Boilerplate Math
    s(
        {
            trig="bpmath",
            descr="Boilerplate for math typesetting",
        },
        fmta(
            [[
                \documentclass[12pt,english]{article}
                \usepackage{tcolorbox}
                \usepackage{microtype}
                \usepackage{amsmath}
                \usepackage{amssymb}
                \usepackage{siunitx}
                \usepackage{fancyhdr}
                \usepackage[margin=3cm]{geometry}

                \pagestyle{fancy}
                \lhead{<>}
                \chead{<>}
                \rhead{<>}

                \title{<>}
                \author{<>}
                \date{}

                \begin{document}
                    \maketitle\thispagestyle{fancy}
                    <>
                \end{document}
            ]],
            {
                i(1,"47436994"),
                i(2),
                i(3, "\\today"),
                i(4),
                i(5, "James Aylward"),
                i(0),
            }
        )
    ),
}
