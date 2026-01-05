let
    Source = Table.Combine({#"TD_Other Income Details L1", #"TD_Other Expenses Details L1"}),
    #"Replaced Value" = Table.ReplaceValue(Source,null,0,Replacer.ReplaceValue,{"Other Income"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",null,0,Replacer.ReplaceValue,{"Other Expenses"}),
    #"Added Custom" = Table.AddColumn(#"Replaced Value1", "Net Other Income", each [Other Income]+[Other Expenses]),
    #"Grouped Rows" = Table.Group(#"Added Custom", {"Period", "Location"}, {{"Adjusted Value", each List.Sum([Net Other Income]), type number}}),
    #"Added Custom1" = Table.AddColumn(#"Grouped Rows", "Level 1", each "Net Other Income"),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom1",{{"Level 1", type text}})
in
    #"Changed Type"