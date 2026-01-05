let
    Source = Table.Combine({#"BS_Liability Details_Subtotal", #"BS_Equity Details_Subtotal"}),
    #"Grouped Rows" = Table.Group(Source, {"Date"}, {{"Amount", each List.Sum([Amount]), type number}}),
    #"Added Custom" = Table.AddColumn(#"Grouped Rows", "Level 1", each "Total Liabilities and Equity"),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom",{{"Level 1", type text}})
in
    #"Changed Type"