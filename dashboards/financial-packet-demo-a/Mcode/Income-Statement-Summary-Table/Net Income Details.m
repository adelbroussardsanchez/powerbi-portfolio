let
    Source = Table.Combine({#"TD_Income Details L1", #"TD_COGS Details L1", #"TD_Expenses Details L1", #"TD_Other Income Details L1", #"TD_Other Expenses Details L1"}),
    #"Replaced Value" = Table.ReplaceValue(Source,null,0,Replacer.ReplaceValue,{"Income"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",null,0,Replacer.ReplaceValue,{"COGS"}),
    #"Replaced Value2" = Table.ReplaceValue(#"Replaced Value1",null,0,Replacer.ReplaceValue,{"Expenses"}),
    #"Replaced Value3" = Table.ReplaceValue(#"Replaced Value2",null,0,Replacer.ReplaceValue,{"Other Income"}),
    #"Replaced Value4" = Table.ReplaceValue(#"Replaced Value3",null,0,Replacer.ReplaceValue,{"Other Expenses"}),
    #"Added Custom" = Table.AddColumn(#"Replaced Value4", "Adjusted Value", each [Income]+[COGS]+[Expenses]+[Other Income]+[Other Expenses]),
    #"Grouped Rows" = Table.Group(#"Added Custom", {"Period", "Location"}, {{"Adjusted Value", each List.Sum([Adjusted Value]), type number}}),
    #"Added Custom1" = Table.AddColumn(#"Grouped Rows", "Level 1", each "Net Income"),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom1",{{"Level 1", type text}})
in
    #"Changed Type"