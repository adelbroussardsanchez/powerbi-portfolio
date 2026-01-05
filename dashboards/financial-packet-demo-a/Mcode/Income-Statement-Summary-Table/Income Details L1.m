let
    Source = #"Transaction Detail",
    #"Merged Queries1" = Table.NestedJoin(Source, {"Account #"}, #"IS_Income Accounts", {"Account #"}, "IS_Gross Profit Accounts", JoinKind.LeftOuter),
    #"Expanded IS_Income Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "IS_Gross Profit Accounts", {"Level 1"}, {"Level 1"}),
    #"Filtered Rows" = Table.SelectRows(#"Expanded IS_Income Accounts", each ([Level 1] = "Income")),
    #"Duplicated Column" = Table.DuplicateColumn(#"Filtered Rows", "Date", "Date - Copy"),
    #"Calculated Start of Month" = Table.TransformColumns(#"Duplicated Column",{{"Date - Copy", Date.StartOfMonth, type date}}),
    #"Renamed Columns4" = Table.RenameColumns(#"Calculated Start of Month",{{"Date - Copy", "Period"}}),
    #"Grouped Rows1" = Table.Group(#"Renamed Columns4", {"Period", "Location"}, {{"Income", each List.Sum([Adjusted Value]), type nullable number}})
in
    #"Grouped Rows1"