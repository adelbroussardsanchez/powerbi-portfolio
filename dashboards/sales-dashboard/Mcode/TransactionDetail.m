let
    Source = Excel.Workbook(Web.Contents("https://[REDACTED].sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/[REDACTED]/DO%20NOT%20MOVE/Transaction%20Detail.xlsx"), null, true),
    #"Transaction Detail by  Account " = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Transaction Detail by  Account ", [PromoteAllScalars=true]),
    #"Removed Other Columns1" = Table.SelectColumns(#"Promoted Headers",{"Date", "Account", "Class", "Amount", "Customer"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Other Columns1", each ([Account] <> null)),
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows",{{"Date", type date}, {"Account", type text}, {"Class", type text}, {"Amount", type number}}),
    #"Merged Queries1" = Table.NestedJoin(#"Changed Type", {"Account"}, #"Chart of Accounts", {"Account"}, "Chart of Accounts", JoinKind.LeftOuter),
    #"Expanded Chart of Accounts" = Table.ExpandTableColumn(#"Merged Queries1", "Chart of Accounts", {"Account #", "Multiply Rules"}, {"Account #", "Multiply Rules"}),
    #"Added Custom" = Table.AddColumn(#"Expanded Chart of Accounts", "Multiplication", each [Amount] * [Multiply Rules]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Custom",{{"Multiplication", type number}}),
    #"Renamed Adjusted Value" = Table.RenameColumns(#"Changed Type1",{{"Multiplication", "Adjusted Value"}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Renamed Adjusted Value",{{"Customer", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type2",null,"N/A",Replacer.ReplaceValue,{"Customer"}),
    #"Added Customer Custom" = Table.AddColumn(#"Replaced Value", "Customer Custom",
    each 
        if Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") then "[REDACTED]"
        else if Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]")then "[REDACTED]"
        else if Text.Contains([#"Customer"], "[REDACTED]") then "[REDACTED]"
        else [Customer]),
    #"Removed Other Columns" = Table.SelectColumns(#"Added Customer Custom",{"Date", "Account", "Class", "Amount", "Customer", "Account #", "Adjusted Value", "Customer Custom"})
in
    #"Removed Other Columns"