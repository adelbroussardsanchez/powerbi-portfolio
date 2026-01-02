let
    Source = #"Balance Sheet",
    #"Merged Queries1" = Table.NestedJoin(Source, {"Account #"}, #"BS_Assets Accounts", {"Account #"}, "BS_Assets Accounts", JoinKind.LeftOuter),
    #"Expanded BS_Assets Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "BS_Assets Accounts", {"Level 1", "Level 2 Conditional", "Level 2 Order", "Level 4", "Level 4 Conditional", "Level 4 Order"}, {"Level 1", "Level 2 Conditional", "Level 2 Order", "Level 4", "Level 4 Conditional", "Level 4 Order"}),
    #"Filtered Rows1" = Table.SelectRows(#"Expanded BS_Assets Accounts", each ([Level 1] = "Assets"))
in
    #"Filtered Rows1"