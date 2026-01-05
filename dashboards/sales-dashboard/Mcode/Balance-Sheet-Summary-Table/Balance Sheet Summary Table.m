let
    Source = Table.Combine({#"BS_Assets Details", #"BS_Assets Details_Subtotal", #"BS_Liability Details", #"BS_Liability Details_Subtotal", #"BS_Equity Details", #"BS_Equity Details_Subtotal", #"BS_LiabilityEquity Details_Total"}),
    #"Added Conditional Column" = Table.AddColumn(Source, "Level 1 Order", each if [Level 1] = "Assets" then 1 else if [Level 1] = "Total Assets" then 2 else if [Level 1] = "Liabilities" then 3 else if [Level 1] = "Total Liabilities" then 4 else if [Level 1] = "Equity" then 5 else if [Level 1] = "Total Equity" then 6 else if [Level 1] = "Total Liabilities and Equity" then 7 else null),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Conditional Column",{{"Level 1 Order", Int64.Type}})
in
    #"Changed Type"