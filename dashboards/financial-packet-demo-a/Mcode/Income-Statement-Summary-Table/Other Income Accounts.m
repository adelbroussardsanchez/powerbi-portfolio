let
    Source = #"Chart of Accounts",
    #"Filtered Rows" = Table.SelectRows(Source, each ([Level 1] = "Other Income"))
in
    #"Filtered Rows"