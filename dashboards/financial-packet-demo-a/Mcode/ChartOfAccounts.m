let
    Source = Excel.Workbook(Web.Contents("https://vgrahamllc.sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/WEC/DO%20NOT%20MOVE/Chart%20of%20Accounts.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Removed Other Columns" = Table.SelectColumns(#"Promoted Headers",{"Account #", "Account", "Type", "Detail type", "Description"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Other Columns",{{"Account #", type text}, {"Account", type text}, {"Type", type text}, {"Detail type", type text}, {"Description", type text}}),
    #"Renamed Level 2 and 4" = Table.RenameColumns(#"Changed Type",{{"Type", "Level 2"}, {"Detail type", "Level 4"}}),
    #"Added Account # 2" = Table.AddColumn(#"Renamed Level 2 and 4", "Account # 2",
    each 
        if [Account] = "J P Morgan Chase Bank - BV:BVC-Baton Rouge" then 1000001 
        else if [Account] = "ERC Receivable" then 1000002 
        else if [Account] = "Inventory Asset-1" then 1000003 
        else if [Account] = "Uncategorized Asset" then 1000004 
        else if [Account] = "Uncategorized Asset ( 625 )" then 1000005 
        else if [Account] = "Accumulated Amortization" then 1000006
        else if [#"Account #"] = "1071*" then 1000007
        else if [#"Account #"] = "1072*" then 1000008
        else if [#"Account #"] = "90000" then 1000009
        else if [Account] = "12012 Prepaid Expenses:Thompson Smith & Leach" then 1000010
        else if [Account] = "American Express:Amber Perkins 61246" then 2000001 
        else if [Account] = "American Express:Blake Williamson ( New -186)" then 2000002 
        else if [Account] = "American Express:Blake Williamson 61196" then 2000003 
        else if [Account] = "American Express:Charles H Williamson - 68001" then 2000004 
        else if [Account] = "American Express:Charles H Williamson 69009" then 2000005
        else if [Account] = "American Express:Charles H Williamson II 64174" then 2000006 
        else if [Account] = "American Express:Charles H. Williamson, II 62178" then 2000007 
        else if [Account] = "American Express:Charlie Ferguson 64166" then 2000008 
        else if [Account] = "American Express:Dineen Goree 62251" then 2000009 
        else if [Account] = "American Express:Gail G. Suchy" then 2000010 
        else if [Account] = "American Express:Lawrence Ferguson 62160" then 2000011 
        else if [Account] = "American Express:Megan Roberts 61238" then 2000012 
        else if [Account] = "American Express:Rachael D. Dunn 62111" then 2000013 
        else if [Account] = "Ink VISA:Visa CHW 3464" then 2000014
        else if [Account] = "American Express:Dineen Goree 61253 (deleted)" then 2000015    
        else if [Account] = "Billable Expense Income" then 4000001 
        else if [Account] = "Markup" then 4000002 
        else if [Account] = "Revenue***" then 4000003 
        else if [Account] = "Sales" then 4000004 
        else if [Account] = "Sales of Product Income" then 4000005 
        else if [Account] = "Shipping Income" then 4000006 
        else if [Account] = "Unapplied Cash Payment Income" then 4000007
        else if [Account] = "Cost of Goods Sold" then 5000001 
        else if [Account] = "Purchases" then 6000001 
        else if [Account] = "Unapplied Cash Bill Payment Expense" then 6000002 
        else if [Account] = "Uncategorized Expense" then 6000003 
        else if [Account] = "Uncategorized Expense ( 623 )" then 6000004
        else if [#"Account #"] = "57000" then 6000005
        else if [#"Account #"] = "57100" then 6000006
        else if [#"Account #"] = "57110" then 6000007
        else if [#"Account #"] = "57120" then 6000008
        else if [#"Account #"] = "57130" then 6000009
        else if [#"Account #"] = "57200" then 6000010
        else if [#"Account #"] = "57210" then 6000011
        else if [#"Account #"] = "57220" then 6000012
        else if [#"Account #"] = "57230" then 6000013
        else if [#"Account #"] = "57240" then 6000014
        else if [#"Account #"] = "57250" then 6000015
        else if [#"Account #"] = "57260" then 6000016
        else if [#"Account #"] = "57270" then 6000017
        else if [#"Account #"] = "57300" then 6000018
        else if [#"Account #"] = "57310" then 6000019
        else if [#"Account #"] = "57320" then 6000020
        else if [#"Account #"] = "57330" then 6000021
        else if [#"Account #"] = "57340" then 6000022
        else if [#"Account #"] = "57350" then 6000023
        else if [#"Account #"] = "57360" then 6000024
        else if [#"Account #"] = "57370" then 6000025
        else if [#"Account #"] = "57380" then 6000026
        else if [#"Account #"] = "57400" then 6000027
        else if [#"Account #"] = "57415" then 6000028
        else if [#"Account #"] = "57420" then 6000029
        else if [#"Account #"] = "57430" then 6000030
        else if [#"Account #"] = "57440" then 6000031
        else if [#"Account #"] = "57450" then 6000032
        else if [#"Account #"] = "57460" then 6000033
        else if [#"Account #"] = "57500" then 6000034
        else if [#"Account #"] = "57510" then 6000035
        else if [#"Account #"] = "57520" then 6000036
        else if [#"Account #"] = "57530" then 6000037
        else if [#"Account #"] = "57540" then 6000038
        else if [#"Account #"] = "57550" then 6000039
        else if [#"Account #"] = "57570" then 6000040
        else if [#"Account #"] = "57580" then 6000041
        else if [#"Account #"] = "57600" then 6000042
        else if [#"Account #"] = "57800" then 6000043
        else if [Account] = "Employee Retention Credit" then 7000001  
        else if [#"Account #"] = "70200" then 8000001 
        else if [#"Account #"] = "70300" then 8000002 
        else if [#"Account #"] = "70350" then 8000003 
        else if [#"Account #"] = "70400" then 8000004 
        else if [#"Account #"] = "70500" then 8000005
        else if [#"Account #"] = "70550" then 8000006 
        else if [Account] = "Reconciliation Discrepancies-1" then 8000007 
        else [#"Account #"]
),
    #"Changed Account # 2 Type" = Table.TransformColumnTypes(#"Added Account # 2",{{"Account # 2", type text}}),
    #"Added Level 1" = Table.AddColumn(#"Changed Account # 2 Type", "Level 1",
    each 
        if Text.StartsWith([#"Account # 2"], "1") then "Assets" 
        else if Text.StartsWith([#"Account # 2"], "2") then "Liabilities" 
        else if Text.StartsWith([#"Account # 2"], "3") then "Equity" 
        else if Text.StartsWith([#"Account # 2"], "4") then "Income" 
        else if Text.StartsWith([#"Account # 2"], "5") then "COGS" 
        else if Text.StartsWith([#"Account # 2"], "6") then "Expenses" 
        else if Text.StartsWith([#"Account # 2"], "7") then "Other Income" 
        else if Text.StartsWith([#"Account # 2"], "8") then "Other Expenses" 
        else null
),
    #"Added Multiply Rules" = Table.AddColumn(#"Added Level 1", "Multiply Rules",
    each 
        if Text.StartsWith([#"Account # 2"], "1") then "-1" 
        else if Text.StartsWith([#"Account # 2"], "2") then "1" 
        else if Text.StartsWith([#"Account # 2"], "3") then "1" 
        else if Text.StartsWith([#"Account # 2"], "4") then "1" 
        else if Text.StartsWith([#"Account # 2"], "5") then "-1" 
        else if Text.StartsWith([#"Account # 2"], "6") then "-1" 
        else if Text.StartsWith([#"Account # 2"], "7") then "1" 
        else if Text.StartsWith([#"Account # 2"], "8") then "-1" 
        else null
),
    #"Added Level 1 Order" = Table.AddColumn(#"Added Multiply Rules", "Level 1 Order", 
    each 
        if Text.StartsWith([#"Account # 2"], "1") then 1 
        else if Text.StartsWith([#"Account # 2"], "2") then 2 
        else if Text.StartsWith([#"Account # 2"], "3") then 3 
        else if Text.StartsWith([#"Account # 2"], "4") then 4 
        else if Text.StartsWith([#"Account # 2"], "5") then 5 
        else if Text.StartsWith([#"Account # 2"], "6") then 6 
        else if Text.StartsWith([#"Account # 2"], "7") then 7 
        else if Text.StartsWith([#"Account # 2"], "8") then 8
        else null
),
    #"Added Report Sheet" = Table.AddColumn(#"Added Level 1 Order", "Report Sheet", 
    each 
        if Text.StartsWith([#"Account # 2"], "1") then "Balance Sheet" 
        else if Text.StartsWith([#"Account # 2"], "2") then "Balance Sheet" 
        else if Text.StartsWith([#"Account # 2"], "3") then "Balance Sheet" 
        else if Text.StartsWith([#"Account # 2"], "4") then "Income Statement" 
        else if Text.StartsWith([#"Account # 2"], "5") then "Income Statement" 
        else if Text.StartsWith([#"Account # 2"], "6") then "Income Statement" 
        else if Text.StartsWith([#"Account # 2"], "7") then "Income Statement" 
        else if Text.StartsWith([#"Account # 2"], "8") then "Income Statement" 
        else null
),
    #"Removed Other Columns1" = Table.SelectColumns(#"Added Report Sheet",{"Account", "Level 2", "Level 4", "Description", "Account # 2", "Level 1", "Multiply Rules", "Level 1 Order", "Report Sheet"}),
    #"Renamed Account #" = Table.RenameColumns(#"Removed Other Columns1",{{"Account # 2", "Account #"}}),
    #"Added Code to CF" = Table.AddColumn(#"Renamed Account #", "Code to CF", 
    each 
        if [#"Account #"] = "30000" then "101"
        else if [#"Level 1"] = "Assets" and (Text.Contains([Account], "Amortization") or Text.Contains([Account], "Depreciation")) then "102"
        else if [#"Account #"] = "12050" then "103"
        else if List.Contains({"12007", "12008", "12011", "12200", "12206", "12210", "12211", "12215", "12205", "12009", "1000010", "22610"}, [#"Account #"]) then "104"
        else if Text.Contains([Account], "Due To/From Intercompany") then "105"
        else if Text.Contains([Account], "Due To/From - Other") then "106"
        else if [#"Level 4"] = "Accounts Payable (A/P)" then "107"
        else if [#"Level 4"] = "Credit Card" then "108"
        else if List.Contains({"15100", "22200", "22300", "22350"}, [#"Account #"]) then "109" 
        else if [#"Account #"] = "22500" then "110"
        else if Text.Contains([Account], "Employee Loans") then "111"
        else if Text.StartsWith([#"Account #"], "14") then "112"
        else if Text.StartsWith([#"Account #"], "15") then "113"
        else if [#"Account #"] = "22910" then "114"
        else if Text.StartsWith([Account], "Notes Payable - ") then "115"
        else if Text.Contains([Account], "Member Equity") then "116"
        else if [#"Account #"] = "32000" then "117"
        else if [#"Account #"] = "9000001" then "118"
        else if [#"Account #"] = "9000002" then "119"
        else null),
    #"Changed Type of Multiple Columns" = Table.TransformColumnTypes(#"Added Code to CF",{{"Level 1", type text}, {"Multiply Rules", Int64.Type}, {"Level 1 Order", Int64.Type}, {"Code to CF", type text}, {"Report Sheet", type text}}),
    #"Duplicated Account" = Table.DuplicateColumn(#"Changed Type of Multiple Columns", "Account", "Account - Copy"),
    #"Split Account by Colon" = Table.SplitColumn(#"Duplicated Account", "Account - Copy", Splitter.SplitTextByDelimiter(":", QuoteStyle.Csv), {"Account - Copy.1", "Account - Copy.2", "Account - Copy.3", "Account - Copy.4", "Account - Copy.5"}),
    #"Added Level 2 Conditional" = Table.AddColumn(#"Split Account by Colon", "Level 2 Conditional",
    each
        if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Bank" then "Current Assets"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account"] = "Capital Stock" then "Capital Stock"
        else if [#"Report Sheet"] = "Balance Sheet" and Text.Contains([Account], "Member Equity") then "Member Equity"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account"] = "Opening Balance Equity" then "Net Income"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account"] = "Retained Earnings" then "Retained Earnings"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Other Current Liabilities" then "Current Liabilities"
	    else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Accounts payable (A/P)" then "Current Liabilities"
	    else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Credit Card" then "Current Liabilities"
	    else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Other Current Liabilities" then "Current Liabilities"
        else if [#"Report Sheet"] = "Balance Sheet" then [#"Level 2"]
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Equity" then [#"Level 4"]
        else if [Account] = "TOPS Managment Fee" then "Management Fee"
        else if [#"Level 1"] = "Expenses" then [#"Account - Copy.1"]
        else if [#"Account - Copy.2"] <> null then [#"Account - Copy.2"]
        else [#"Account - Copy.1"]
),
    #"Added Level 2 Order" = Table.AddColumn(#"Added Level 2 Conditional", "Level 2 Order",
    each
        if [#"Level 2 Conditional"] = "Current Assets" then 101
        else if [#"Level 2 Conditional"] = "Other Current Assets" then 102
        else if [#"Level 2 Conditional"] = "Fixed Assets" then 103
        else if [#"Level 2 Conditional"] = "Other Assets" then 104
        else if [#"Level 2 Conditional"] = "Current Liabilities" then 201
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" then 202
        else if [#"Level 2 Conditional"] = "Member Equity" then 301
        else if [#"Level 2 Conditional"] = "Capital Stock" then 302
        else if [#"Level 2 Conditional"] = "Retained Earnings" then 303
        else if [#"Level 2 Conditional"] = "Net Income" then 304
        else if [#"Level 2 Conditional"] = "Revenue-" then 401
        else if [#"Level 2 Conditional"] = "Physician Services" then 402
        else if [#"Level 1"] = "Income" and [#"Level 2 Conditional"] = "Other Income" then 403
        else if [#"Level 2 Conditional"] = "Retail" then 404
        else if [#"Level 2 Conditional"] = "US HHS Stimulus" then 405
        else if [#"Level 2 Conditional"] = "Reverse PLB" then 406
        else if [#"Level 2 Conditional"] = "Uncategorized Income" then 407
        else if [#"Level 2 Conditional"] = "Billable Expense Income" then 408
        else if [#"Level 2 Conditional"] = "Markup" then 409
        else if [#"Level 2 Conditional"] = "Revenue***" then 410
        else if [#"Level 2 Conditional"] = "Sales" then 411
        else if [#"Level 2 Conditional"] = "Sales of Product Income" then 412
        else if [#"Level 2 Conditional"] = "Shipping Income" then 413
        else if [#"Level 2 Conditional"] = "Unapplied Cash Payment Income" then 413
        else if [#"Level 2 Conditional"] = "Direct Expenses" then 501
        else if [#"Level 2 Conditional"] = "Purchases - Retail" then 502
        else if [#"Level 2 Conditional"] = "Outside Services" then 503
        else if [#"Level 2 Conditional"] = "Management -General Supervision" then 504
        else if [#"Level 2 Conditional"] = "Supplies" then 505
        else if [#"Level 2 Conditional"] = "Equipment" then 506
        else if [#"Level 2 Conditional"] = "Freight" then 507
        else if [#"Level 2 Conditional"] = "Cost of Goods Sold" then 508
        else if [#"Level 2 Conditional"] = "Payroll Compensation & Benefits" then 601
        else if [#"Level 2 Conditional"] = "Building and Facilities" then 602
        else if [#"Level 2 Conditional"] = "Sales and Marketing" then 603
        else if [#"Level 2 Conditional"] = "General and Administrative" then 604
        else if [#"Level 2 Conditional"] = "Reconciliation Discrepancies" then 605
        else if [#"Level 2 Conditional"] = "Purchases" then 606
        else if [#"Level 2 Conditional"] = "Unapplied Cash Bill Payment Expense" then 607
        else if [#"Level 2 Conditional"] = "Uncategorized Expense" then 608
        else if [#"Level 2 Conditional"] = "Uncategorized Expense ( 623 )" then 609
        else if [#"Level 2 Conditional"] = "Other Income" then 701
        else if [#"Level 2 Conditional"] = "Interest Income" then 702
        else if [#"Level 2 Conditional"] = "Rebate Income" then 703
        else if [#"Level 2 Conditional"] = "TOPS Managment Fee" then 704
        else if [#"Level 2 Conditional"] = "Employee Retention Credit" then 705
        else if [#"Level 2 Conditional"] = "Other Expenses" then 801
        else if [#"Level 2 Conditional"] = "Depreciation Expense" then 802
        else if [#"Level 2 Conditional"] = "Amortization Expense" then 803
        else if [#"Level 2 Conditional"] = "Interest Expense" then 804
        else if [#"Level 2 Conditional"] = "VOID" then 805
        else if [#"Level 2 Conditional"] = "Provider's Reconcilations" then 806
        else if [#"Level 2 Conditional"] = "Reconciliation Discrepancies-1" then 807
        else null
),
    #"Added Level 4 Conditional" = Table.AddColumn(#"Added Level 2 Order", "Level 4 Conditional",
    each
        if [#"Report Sheet"] = "Balance Sheet" and [#"Level 4"] = "Checking" then "Cash"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account"] = "Employee Retention Receivable" then "Employee Retention Receivable"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account - Copy.1"] = "Prepaid Expenses" then "Prepaid Expenses"
        else if [#"Report Sheet"] = "Balance Sheet" and Text.Contains([Account], "Due To/From Intercompany") then "Due To/From Intercompany"
        else if [#"Report Sheet"] = "Balance Sheet" and Text.Contains([Account], "Due To/From - Other") then "Due To/From - Other"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14000" then "Acquisition Costs"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14100" then "Building Improvement"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14350" then "Computer Software"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14400" then "Fixed Assets - ALL"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14500" then "Furniture & Fixtures"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14550" then "Equipment"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14600" then "Land"
        else if [#"Report Sheet"] = "Balance Sheet" and Text.Contains([Account], "Medical Equipment") then "Medical Equipment"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "14800" then "Leasehold Improvement"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "17000" then "Accumulated Depreciation"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "20000" then "Accounts Payable"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Credit Card" then "Credit Cards"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Other Current Liabilities" then "Other Current Liabilities"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Level 2"] = "Credit Card" then "Credit Cards"
        else if [#"Report Sheet"] = "Balance Sheet" and Text.Contains([Account], "Notes Payable - Long Term") then "Notes Payable - Long Term"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "1072" then "Level 4 Placeholder 1"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "13000" then "Level 4 Placeholder 2"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30100" then "Level 4 Placeholder 3"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "32000" then "Level 4 Placeholder 4"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30110" then "Level 4 Placeholder 5"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30120" then "Level 4 Placeholder 6"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30130" then "Level 4 Placeholder 7"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30135" then "Level 4 Placeholder 8"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30150" then "Level 4 Placeholder 9"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30160" then "Level 4 Placeholder 10"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "30000" then "Level 4 Placeholder 11"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "15100" then "Level 4 Placeholder 12"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "15200" then "Level 4 Placeholder 13"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "15201" then "Level 4 Placeholder 14"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "15202" then "Level 4 Placeholder 15"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "15203" then "Level 4 Placeholder 16"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account #"] = "15250" then "Level 4 Placeholder 17"
        else if [#"Report Sheet"] = "Balance Sheet" and [#"Account"] = "Accumulated Amortization" then "Level 4 Placeholder 18"
        else null
),
    #"Added Level 4 Order" = Table.AddColumn(#"Added Level 4 Conditional", "Level 4 Order",
    each
        if [#"Level 4 Conditional"] = "Cash" then 101
        else if [#"Level 4 Conditional"] = "Level 4 Placeholder 1" then 102
        else if [#"Level 4 Conditional"] = "Employee Retention Receivable" then 103
        else if [#"Level 4 Conditional"] = "Level 4 Placeholder 1" then 104
        else if [#"Level 4 Conditional"] = "Prepaid Expenses" then 105
        else if [#"Level 4 Conditional"] = "Due To/From Intercompany" then 106
        else if [#"Level 4 Conditional"] = "Due To/From - Other" then 107
        else if [#"Level 4 Conditional"] = "Acquisition Costs" then 108
        else if [#"Level 4 Conditional"] = "Building Improvement" then 109
        else if [#"Level 4 Conditional"] = "Computer Software" then 110
        else if [#"Level 4 Conditional"] = "Fixed Assets - ALL" then 111
        else if [#"Level 4 Conditional"] = "Furniture & Fixtures" then 112
        else if [#"Level 4 Conditional"] = "Equipment" then 113
        else if [#"Level 4 Conditional"] = "Land" then 114
        else if [#"Level 4 Conditional"] = "Leasehold Improvement" then 115
        else if [#"Level 4 Conditional"] = "Medical Equipment" then 116
        else if [#"Level 4 Conditional"] = "Accumulated Depreciation" then 117
        else if [#"Level 1"] = "Total Assets" then 118
        else if [#"Level 4 Conditional"] = "Accounts Payable" then 201
        else if [#"Level 4 Conditional"] = "Credit Cards" then 202
        else if [#"Level 4 Conditional"] = "Other Current Liabilities" then 203
        else if [#"Level 4 Conditional"] = "Notes Payable - Long Term" then 204
        else if [#"Level 1"] = "Total Liabilities" then 205
        else if [#"Level 4"] = "Owner's Equity" then 301
        else if [#"Level 4"] = "Retained Earnings" then 302
        else if [#"Level 4"] = "Opening Balance Equity" then 303
        else if [#"Level 1"] = "Total Equity" then 304
        else if [#"Level 1"] = "Total Liabilities and Equity" then 901
        else if [#"Level 4"] = "Cash on hand" then 902
        else if [#"Level 4"] = "Other Current Assets" then 903
        else if [#"Level 4"] = "Other fixed assets" then 904
        else if [#"Level 4"] = "Other Long-term Assets" then 905
        else null 
),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Level 4 Order",{{"Level 2 Conditional", type text}, {"Level 2 Order", Int64.Type}})
in
    #"Changed Type1"