let
    Source = Excel.Workbook(Web.Contents("https://[REDACTED].sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/[REDACTED]/DO%20NOT%20MOVE/P&L%20by%20Customer.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Unpivoted Other Columns" = Table.UnpivotOtherColumns(#"Promoted Headers", {"Distribution account"}, "Attribute", "Value"),
    #"Renamed Columns" = Table.RenameColumns(#"Unpivoted Other Columns",{{"Attribute", "Client"}, {"Value", "Amount"}, {"Distribution account", "Account"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Account", type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Changed Type",{{"Account", Text.Trim, type text}}),
    #"Filtered Rows1" = Table.SelectRows(#"Trimmed Text", each ([Account] <> "Total Cost of Goods Sold" and [Account] <> "Total Expenses" and [Account] <> "Total for Cost of Goods Sold" and [Account] <> "Total for Expenses" and [Account] <> "Total for General & Administrative" and [Account] <> "Total for Income" and [Account] <> "Total for Insurance Expense" and [Account] <> "Total for Legal & Professional Fees" and [Account] <> "Total for Other Expenses" and [Account] <> "Total for Other Income" and [Account] <> "Total for Salaries & Benefits" and [Account] <> "Total for Sales" and [Account] <> "Total for Sales Allowance, Discount & Ret" and [Account] <> "Total General & Administrative" and [Account] <> "Total Income" and [Account] <> "Total Insurance Expense" and [Account] <> "Total Legal & Professional Fees" and [Account] <> "Total Organic Honey" and [Account] <> "Total Other Expenses" and [Account] <> "Total Other Income" and [Account] <> "Total Salaries & Benefits" and [Account] <> "Total Sales" and [Account] <> "Total Sales Allowance, Discount & Ret")),
    #"Merged Queries" = Table.FuzzyNestedJoin(#"Filtered Rows1", {"Account"}, #"Chart of Accounts", {"Account"}, "Chart of Accounts", JoinKind.LeftOuter, [IgnoreCase=true, IgnoreSpace=true]),
    #"Expanded Chart of Accounts" = Table.ExpandTableColumn(#"Merged Queries", "Chart of Accounts", {"Account #"}, {"Account #"}),
    #"Added Account # 2" = Table.AddColumn(#"Expanded Chart of Accounts", "Account # 2",
    each 
        if [Account] = "Organic Honey - 12 oz" then 400012
        else if [Account] = "Organic Honey - 16 oz" then 400013
        else if [Account] = "Organic Honey - 32 oz" then 400014
        else if [Account] = "Organic Honey - 40 oz" then 400015
        else if [Account] = "Sales Allowance - Damage & Returns" then 400025 
        else if [Account] = "Sales Allowance - Netting" then 400027
        else if [Account] = "Sales Allowance - Non-Performance" then 400028
        else if [Account] = "Sales Allowance - Other" then 400029
        else if [Account] = "Sales Allowance - Promotions" then 400030
        else if [Account] = "Sales Returns - Other" then 400033
        else if [Account] = "*Cost of Goods Sold" then 500001
        else if [Account] = "Cost of Goods Sold - Other" then 500021
        else if [Account] = "Drug Screen / Background Check" then 600008
        else if [Account] = "Compliance" then 600016
        else if [Account] = "Facility" then 600018
        else if [Account] = "Insurance Expense" then 600019
        else if [Account] = "Health Insurance" then 600021
        else if [Account] = "Workers Comp Insurance" then 600022
        else if [Account] = "Accounting" then 600024
        else if [Account] = "Consulting" then 600025
        else if [Account] = "Professional Services" then 600026
        else if [Account] = "Postage" then 600029
        else if [Account] = "Printing" then 600030
        else if [Account] = "Supplies" then 600034
        else if [Account] = "Telephone Expense" then 600035
        else if [Account] = "Utilities" then 600036
        else if [Account] = "Salaries & Benefits" then 600046
        else if [Account] = "Retirement" then 600049
        else if [Account] = "Wages" then 600050
        else if [Account] = "Net Other Income" then null
        else [#"Account #"]
    ),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Account # 2",{{"Account # 2", type text}}),
    #"Added Level 1" = Table.AddColumn(#"Changed Type1", "Level 1",
    each 
        if [Account] = "Gross Profit" then "Gross Profit"
        else if [Account] = "Net Operating Income" then "Net Operating Income"
        else if [Account] = "Net Other Income" then "Net Other Income"
        else if [Account] = "Payroll Tax" then "Expenses"
        else if [Account] = "Net Income" then "Net Income"
        else if Text.StartsWith([#"Account # 2"], "1") then "Assets" 
        else if Text.StartsWith([#"Account # 2"], "2") then "Liabilities" 
        else if Text.StartsWith([#"Account # 2"], "3") then "Equity" 
        else if Text.StartsWith([#"Account # 2"], "4") then "Income" 
        else if Text.StartsWith([#"Account # 2"], "5") then "COGS" 
        else if Text.StartsWith([#"Account # 2"], "6") then "Expenses" 
        else if Text.StartsWith([#"Account # 2"], "7") then "Other Income" 
        else if Text.StartsWith([#"Account # 2"], "8") then "Other Expenses" 
        else null
    ),
    #"Added Level 2" = Table.AddColumn(#"Added Level 1", "Level 2",
    each 
        if List.Contains({"Conventional Honey", "Organic Honey", "Regional Honey", "Organic Honey - 12 oz", "Organic Honey - 16 oz", "Organic Honey - 32 oz", "Organic Honey - 40 oz"}, [Account]) and [#"Level 1"] = "Income" then "Sales"
        else if [Account] = "Sales" and [#"Level 1"] = "Income" then "Sales"
        else if Text.StartsWith([Account], "Sales") and [#"Level 1"] = "Income" then "Sales Allowance, Discount & Ret"
        else if [#"Level 1"] = "COGS" then [Account]
        else if [#"Level 1"] = "Expenses" then [Account]
        else if [#"Level 1"] = "Other Income" then [Account]
        else if [#"Level 1"] = "Other Expenses" then [Account]
        else if [#"Level 1"] = "Gross Profit" then "Gross Profit"
        else if [#"Level 1"] = "Net Operating Income" then "Net Operating Income"
        else if [#"Level 1"] = "Net Other Income" then "Net Other Income"
        else if [Account] = "Net Income" then "Net Income"
        else null 
    ),
    #"Added Level 1 Order" = Table.AddColumn(#"Added Level 2", "Level 1 Order",
    each 
        if [#"Level 1"] = "Income" then "1"
        else if [#"Level 1"] = "COGS" then "2"
        else if [#"Level 1"] = "Gross Profit" then "3"
        else if [#"Level 1"] = "Expenses" then "4"
        else if [#"Level 1"] = "Net Operating Income" then "5"
        else if [#"Level 1"] = "Other Income" then "6"
        else if [#"Level 1"] = "Other Expenses" then "7"
        else if [#"Level 1"] = "Net Other Income" then "8"
        else if [#"Level 1"] = "Net Income" then "9"
        else null 
    ),
    #"Renamed Columns1" = Table.RenameColumns(#"Added Level 1 Order",{{"Client", "Customer"}}),
    #"Added Customer Custom" = Table.AddColumn(#"Renamed Columns1", "Customer Custom",
    each 
        if Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") then "[REDACTED]"
        else if Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]") or Text.Contains([#"Customer"], "[REDACTED]")then "[REDACTED]"
        else if Text.Contains([#"Customer"], "[REDACTED]") then "[REDACTED]"
        else if List.Contains({"[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]"}, [Customer]) then "Other"
        else if List.Contains({"[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]", "[REDACTED]"}, [Customer]) then "Local"
        else if List.Contains({"Donation", "[REDACTED]", "[REDACTED]", "[REDACTED]", [REDACTED]"}, [Customer]) then "Donations"
        else [Customer]),
    #"Merged Queries1" = Table.NestedJoin(#"Added Customer Custom", {"Account # 2"}, #"Chart of Accounts", {"Account #"}, "Chart of Accounts", JoinKind.LeftOuter),
    #"Expanded Chart of Accounts1" = Table.ExpandTableColumn(#"Merged Queries1", "Chart of Accounts", {"Multiply Rules"}, {"Multiply Rules"}),
    #"Added Custom" = Table.AddColumn(#"Expanded Chart of Accounts1", "Adjusted Value", each [Amount] * [Multiply Rules]),
    #"Added Adjusted Value 2" = Table.AddColumn(#"Added Custom", "Adjusted Value 2",
    each 
        if [#"Adjusted Value"] = null then [Amount]
        else [#"Adjusted Value"]
    ),
    #"Removed Columns" = Table.RemoveColumns(#"Added Adjusted Value 2",{"Adjusted Value", "Account #"}),
    #"Renamed Columns2" = Table.RenameColumns(#"Removed Columns",{{"Adjusted Value 2", "Adjusted Value"}, {"Account # 2", "Account #"}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Renamed Columns2",{{"Adjusted Value", type number}, {"Multiply Rules", Int64.Type}}),
    #"Removed Duplicates" = Table.Distinct(#"Changed Type2"),
    #"Filtered Rows" = Table.SelectRows(#"Removed Duplicates", each ([Customer] <> "Total" and [Customer] <> "TOTAL")),
    #"Changed Type3" = Table.TransformColumnTypes(#"Filtered Rows",{{"Level 1", type text}, {"Level 2", type text}, {"Customer Custom", type text}, {"Amount", type number}, {"Level 1 Order", Int64.Type}})
in
    #"Changed Type3"