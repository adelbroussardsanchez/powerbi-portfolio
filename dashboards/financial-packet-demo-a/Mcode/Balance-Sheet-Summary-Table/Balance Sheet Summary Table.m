let
    Source = Table.Combine({#"BS_Assets Details", #"BS_Assets Details_Subtotal", #"BS_Liability Details", #"BS_Liability Details_Subtotal", #"BS_Equity Details", #"BS_Equity Details_Subtotal", #"BS_LiabilityEquity Details_Total"}),
    #"Added Conditional Column" = Table.AddColumn(Source, "Level 1 Order", each if [Level 1] = "Assets" then 1 else if [Level 1] = "Total Assets" then 2 else if [Level 1] = "Liabilities" then 3 else if [Level 1] = "Total Liabilities" then 4 else if [Level 1] = "Equity" then 5 else if [Level 1] = "Total Equity" then 6 else if [Level 1] = "Total Liabilities and Equity" then 7 else null),
    #"Added Level 4 Order Custom" = Table.AddColumn(#"Added Conditional Column", "Level 4 Order Custom",
    each
        if [#"Level 1"] = "Total Assets" then 116
        else if [#"Level 1"] = "Total Liabilities" then 205
        else if [#"Level 1"] = "Total Equity" then 304
        else if [#"Level 1"] = "Total Liabilities and Equity" then 990
        else [Level 4 Order]
),
    #"Added Level 4 Conditional Custom" = Table.AddColumn(#"Added Level 4 Order Custom", "Level 4 Conditional Custom",
    each
        if [#"Level 1"] = "Total Assets" then "Level 4 Placeholder 19"
        else if [#"Level 1"] = "Total Liabilities" then "Level 4 Placeholder 20"
        else if [#"Level 1"] = "Total Equity" then "Level 4 Placeholder 21"
        else if [#"Level 1"] = "Total Liabilities and Equity" then "Level 4 Placeholder 22"
        else [Level 4 Conditional]
),

    #"Changed Type" = Table.TransformColumnTypes(#"Added Level 4 Conditional Custom",{{"Level 1 Order", Int64.Type}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each true),
    #"Changed Type1" = Table.TransformColumnTypes(#"Filtered Rows",{{"Level 4 Order Custom", Int64.Type}})
in
    #"Changed Type1"