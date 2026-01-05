let
    Source = #"Chart of Accounts",
    #"Filtered Rows" = Table.SelectRows(Source, each ([Level 1] = "COGS" or [Level 1] = "Income"))
in
    #"Filtered Rows"