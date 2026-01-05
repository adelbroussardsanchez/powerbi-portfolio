let
    Source = #"Balance Sheet",
    #"Merged Queries1" = Table.NestedJoin(Source, {"Account #"}, #"BS_Liability Accounts", {"Account #"}, "BS_Liability Accounts", JoinKind.LeftOuter),
    #"Expanded BS_Liability Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "BS_Liability Accounts", {"Level 1", "Level 1 Order", "Level 2 Conditional", "Level 2 Order", "Level 4", "Level 4 Custom", "Level 4 Custom Order"}, {"Level 1", "Level 1 Order", "Level 2 Conditional", "Level 2 Order", "Level 4", "Level 4 Custom", "Level 4 Custom Order"}),
    #"Filtered Rows" = Table.SelectRows(#"Expanded BS_Liability Accounts", each ([Level 1] = "Liabilities")),
    #"Grouped Rows" = Table.Group(#"Filtered Rows", {"Level 1", "Date"}, {{"Amount", each List.Sum([Amount]), type number}}),
    #"Replaced Value" = Table.ReplaceValue(#"Grouped Rows","Liabilities","Total Liabilities",Replacer.ReplaceText,{"Level 1"})
in
    #"Replaced Value"