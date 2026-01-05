let
    Source = Excel.Workbook(Web.Contents("https://[REDACTED].sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/[REDACTED]/DO%20NOT%20MOVE/Customer%20List.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Customer", type any}}),
    #"Removed Blank Rows" = Table.SelectRows(#"Changed Type", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Removed Duplicates" = Table.Distinct(#"Removed Blank Rows"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Removed Duplicates",{{"Customer", type text}}),
    #"Added Customer Custom" = Table.AddColumn(#"Changed Type1", "Customer Custom",
    each 
        if Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") then "[REDACTED]"
        else if Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]")then "[REDACTED]"
        else if Text.Contains([#"Customer"], "[REDACTED]") then "[REDACTED]"
        else [Customer]),
    #"Changed Type2" = Table.TransformColumnTypes(#"Added Customer Custom",{{"Customer Custom", type text}})
in
    #"Changed Type2"