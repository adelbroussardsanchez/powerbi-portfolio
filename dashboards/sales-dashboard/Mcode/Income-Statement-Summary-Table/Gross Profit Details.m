let
    Source = #"Transaction Detail",
    #"Merged Queries1" = Table.NestedJoin(Source, {"Account #"}, #"IS_Gross Profit Accounts", {"Account #"}, "IS_Gross Profit Accounts", JoinKind.LeftOuter),
    #"Expanded IS_Gross Profit Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "IS_Gross Profit Accounts", {"Level 1"}, {"Level 1"}),
    #"Filtered Rows" = Table.SelectRows(#"Expanded IS_Gross Profit Accounts", each ([Level 1] <> null)),
    #"Duplicated Column" = Table.DuplicateColumn(#"Filtered Rows", "Date", "Date - Copy"),
    #"Calculated Start of Month" = Table.TransformColumns(#"Duplicated Column",{{"Date - Copy", Date.StartOfMonth, type date}}),
    #"Renamed Columns4" = Table.RenameColumns(#"Calculated Start of Month",{{"Date - Copy", "Period"}}),
    #"Grouped Rows1" = Table.Group(#"Renamed Columns4", {"Period", "Class"}, {{"Adjusted Value", each List.Sum([Adjusted Value]), type nullable number}}),
    #"Added Custom1" = Table.AddColumn(#"Grouped Rows1", "Level 1", each "Gross Profit"),
    #"Changed Type3" = Table.TransformColumnTypes(#"Added Custom1",{{"Level 1", type text}}),
    #"Duplicated Column1" = Table.DuplicateColumn(#"Changed Type3", "Period", "Period - Copy"),
    #"Changed Type4" = Table.TransformColumnTypes(#"Duplicated Column1",{{"Period - Copy", type text}}),
    #"Replaced Value27" = Table.ReplaceValue(#"Changed Type4",null,"",Replacer.ReplaceValue,{"Class"}),
    #"Added Custom2" = Table.AddColumn(#"Replaced Value27", "PK", each [#"Period - Copy"]&[Class]),
    #"Changed Type5" = Table.TransformColumnTypes(#"Added Custom2",{{"PK", type text}})
in
    #"Changed Type5"