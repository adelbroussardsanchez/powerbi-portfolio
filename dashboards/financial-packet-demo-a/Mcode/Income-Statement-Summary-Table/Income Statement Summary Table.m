let
    Source = Table.Combine({#"TD_Income Details", #"TD_COGS Details", #"TD_Gross Profit Details", #"TD_Gross Profit % Details", #"TD_Expenses Details", #"TD_Net Operating Income Details", #"TD_Other Income Details", #"TD_Other Expenses Details", #"TD_Net Other Income Details", #"TD_Net Income Details"}),
    #"Added Conditional Column" = Table.AddColumn(Source, "Level 1 Order", each if [Level 1] = "Income" then 1 else if [Level 1] = "COGS" then 2 else if [Level 1] = "Gross Profit" then 3 else if [Level 1] = "Gross Profit %" then 4 else if [Level 1] = "Expenses" then 5 else if [Level 1] = "Net Operating Income" then 6 else if [Level 1] = "Other Income" then 7 else if [Level 1] = "Other Expenses" then 8 else if [Level 1] = "Net Other Income" then 9 else if [Level 1] = "Net Income" then 10 else null),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Conditional Column",{{"Level 1 Order", Int64.Type}})
in
    #"Changed Type"