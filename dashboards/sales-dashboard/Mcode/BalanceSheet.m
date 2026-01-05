let
    Source = Excel.Workbook(Web.Contents("https://[REDACTED].sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/[REDACTED]/DO%20NOT%20MOVE/Balance%20Sheet.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Renamed Columns" = Table.RenameColumns(#"Promoted Headers",{{"Column1", "Account"}}),
    #"Filtered Rows2" = Table.SelectRows(#"Renamed Columns", each ([Account] <> null)),
    #"Unpivoted Columns" = Table.UnpivotOtherColumns(#"Filtered Rows2", {"Account"}, "Attribute", "Value"),
    #"Changed Type" = Table.TransformColumnTypes(#"Unpivoted Columns",{{"Account", type text}, {"Attribute", type date}, {"Value", type number}}),
    #"Rounded Off" = Table.TransformColumns(#"Changed Type",{{"Value", each Number.Round(_, 2), type number}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Rounded Off",{{"Attribute", "Date"}, {"Value", "Amount"}}),
    #"Trimmed Text" = Table.TransformColumns(#"Renamed Columns1",{{"Account", Text.Trim, type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Trimmed Text", each not Text.StartsWith([Account], "TOTAL") and not Text.StartsWith([Account], "Total")),
    #"Merged Queries1" = Table.NestedJoin(#"Filtered Rows", {"Account"}, #"Chart of Accounts", {"Account"}, "Chart of Accounts", JoinKind.LeftOuter),
    #"Expanded Chart of Accounts1" = Table.ExpandTableColumn(#"Merged Queries1", "Chart of Accounts", {"Account #"}, {"Account #"}),
    #"Added Conditional Column" = Table.AddColumn(#"Expanded Chart of Accounts1", "Custom", each if [Account] = "[REDACTED]" then 200002 else null),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Conditional Column",{{"Custom", type text}}),
    #"Added Conditional Column1" = Table.AddColumn(#"Changed Type1", "Custom.1", each if [#"Account #"] = null then [Custom] else [#"Account #"]),
    #"Removed Other Columns" = Table.SelectColumns(#"Added Conditional Column1",{"Account", "Date", "Amount", "Custom.1"}),
    #"Renamed Columns2" = Table.RenameColumns(#"Removed Other Columns",{{"Custom.1", "Account #"}}),
    #"Sorted Rows1" = Table.Sort(#"Renamed Columns2",{{"Date", Order.Ascending}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Sorted Rows1",{{"Account #", type text}})
in
    #"Changed Type2"