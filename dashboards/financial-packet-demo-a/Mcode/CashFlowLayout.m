let
    Source = Excel.Workbook(Web.Contents("https://[REDACTED].sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/[REDACTED]/DO%20NOT%20MOVE/WEC%20CF%20Layout.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Level 1", type text}, {"Level 2", type text}, {"Level 1 Order", Int64.Type}, {"Level 2 Order", Int64.Type}, {"Code to COA", type text}}),
    #"Removed Blank Rows" = Table.SelectRows(#"Changed Type", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Trimmed Text" = Table.TransformColumns(#"Removed Blank Rows",{{"Level 2", Text.Trim, type text}}),
    #"Cleaned Text" = Table.TransformColumns(#"Trimmed Text",{{"Level 2", Text.Clean, type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Cleaned Text", each ([Level 1] <> "Net cash provided by operating activities"))
in
    #"Filtered Rows"