let
    Source = #"Balance Sheet",
    #"Merged Queries1" = Table.NestedJoin(Source, {"Account #"}, #"BS_Liability Accounts", {"Account #"}, "BS_Liability Accounts", JoinKind.LeftOuter),
    #"Expanded BS_Liability Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "BS_Liability Accounts", {"Level 1", "Level 2 Conditional", "Level 2 Order", "Level 4", "Level 4 Custom", "Level 4 Custom Order"}, {"Level 1", "Level 2 Conditional", "Level 2 Order", "Level 4", "Level 4 Custom", "Level 4 Custom Order"}),
    #"Filtered Rows" = Table.SelectRows(#"Expanded BS_Liability Accounts", each ([Level 1] = "Liabilities"))
in
    #"Filtered Rows"