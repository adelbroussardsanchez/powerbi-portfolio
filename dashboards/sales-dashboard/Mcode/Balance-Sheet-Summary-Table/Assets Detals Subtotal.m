let
    Source = #"Balance Sheet",
    #"Merged Queries1" = Table.NestedJoin(Source, {"Account #"}, #"BS_Assets Accounts", {"Account #"}, "BS_Assets Accounts", JoinKind.LeftOuter),
    #"Expanded BS_Assets Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "BS_Assets Accounts", {"Level 1", "Level 1 Order", "Level 2 Conditional", "Level 2 Order", "Level 4 Custom", "Level 4 Custom Order"}, {"Level 1", "Level 1 Order", "Level 2 Conditional", "Level 2 Order", "Level 4 Custom", "Level 4 Custom Order"}),
    #"Filtered Rows1" = Table.SelectRows(#"Expanded BS_Assets Accounts", each ([Level 1] = "Assets")),
    #"Grouped Rows" = Table.Group(#"Filtered Rows1", {"Level 1", "Date"}, {{"Amount", each List.Sum([Amount]), type number}}),
    #"Replaced Value" = Table.ReplaceValue(#"Grouped Rows","Assets","Total Assets",Replacer.ReplaceText,{"Level 1"})
in
    #"Replaced Value"