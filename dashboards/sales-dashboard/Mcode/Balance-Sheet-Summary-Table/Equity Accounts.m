let
    Source = #"Chart of Accounts",
    #"Filtered Rows" = Table.SelectRows(Source, each ([Level 1] = "Equity"))
in
    #"Filtered Rows"