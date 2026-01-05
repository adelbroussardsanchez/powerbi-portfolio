let
    Source = Excel.Workbook(Web.Contents("https://[REDACTED].sharepoint.com/sites/PowerBIDashboards/Shared%20Documents/General/PowerBI%20Clients/[REDACTED]/DO%20NOT%20MOVE/COA.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Removed Other Columns" = Table.SelectColumns(#"Promoted Headers",{"Account #", "Account", "Type", "Detail type", "Description"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Other Columns", each ([#"Account #"] <> null)),
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows",{{"Account #", type text}, {"Account", type text}, {"Type", type text}, {"Detail type", type text}, {"Description", type text}}),
    #"Renamed Level 2 and 4" = Table.RenameColumns(#"Changed Type",{{"Type", "Level 2"}, {"Detail type", "Level 4"}}),
    #"Added Level 1" = Table.AddColumn(#"Renamed Level 2 and 4", "Level 1",
    each 
        if Text.StartsWith([#"Account #"], "1") then "Assets" 
        else if Text.StartsWith([#"Account #"], "2") then "Liabilities" 
        else if Text.StartsWith([#"Account #"], "3") then "Equity" 
        else if Text.StartsWith([#"Account #"], "4") then "Income" 
        else if Text.StartsWith([#"Account #"], "5") then "COGS" 
        else if Text.StartsWith([#"Account #"], "6") then "Expenses" 
        else if Text.StartsWith([#"Account #"], "7") then "Other Income" 
        else if Text.StartsWith([#"Account #"], "8") then "Other Expenses" 
        else null
),
    #"Added Report Sheet" = Table.AddColumn(#"Added Level 1", "Report Sheet",
    each 
        if Text.StartsWith([#"Account #"], "1") then "Balance Sheet" 
        else if Text.StartsWith([#"Account #"], "2") then "Balance Sheet" 
        else if Text.StartsWith([#"Account #"], "3") then "Balance Sheet" 
        else if Text.StartsWith([#"Account #"], "4") then "Income Statement" 
        else if Text.StartsWith([#"Account #"], "5") then "Income Statement" 
        else if Text.StartsWith([#"Account #"], "6") then "Income Statement" 
        else if Text.StartsWith([#"Account #"], "7") then "Income Statement" 
        else if Text.StartsWith([#"Account #"], "8") then "Income Statement" 
        else null
),
    #"Added Multiply Rules" = Table.AddColumn(#"Added Report Sheet", "Multiply Rules",
    each 
        if Text.StartsWith([#"Account #"], "1") then "-1" 
        else if Text.StartsWith([#"Account #"], "2") then "1" 
        else if Text.StartsWith([#"Account #"], "3") then "1" 
        else if Text.StartsWith([#"Account #"], "4") then "1" 
        else if Text.StartsWith([#"Account #"], "5") then "-1" 
        else if Text.StartsWith([#"Account #"], "6") then "-1" 
        else if Text.StartsWith([#"Account #"], "7") then "1" 
        else if Text.StartsWith([#"Account #"], "8") then "-1" 
        else null
),
    #"Added Level 1 Order" = Table.AddColumn(#"Added Multiply Rules", "Level 1 Order", 
    each 
        if Text.StartsWith([#"Account #"], "1") then "1" 
        else if Text.StartsWith([#"Account #"], "2") then "2" 
        else if Text.StartsWith([#"Account #"], "3") then "3" 
        else if Text.StartsWith([#"Account #"], "4") then "4" 
        else if Text.StartsWith([#"Account #"], "5") then "5" 
        else if Text.StartsWith([#"Account #"], "6") then "6" 
        else if Text.StartsWith([#"Account #"], "7") then "7" 
        else if Text.StartsWith([#"Account #"], "8") then "8" 
        else null
),
    #"Added Code to CF" = Table.AddColumn(#"Added Level 1 Order", "Code to CF", each if [#"Account #"] = "300000" then "100"
        else if [#"Account #"] = "900001" then "101" // Adjustments to reconcile Net Income to Net Cash provided by Operations
        else if [#"Account #"] = "900002" then "122" // Net cash provided by operating activities
        else if [#"Account #"] = "900003" then "123" // Net Cash Increase (Decrease) for Period
        else if [#"Account #"] = "600007" then "102" // Depreciation
        else if [#"Account #"] = "100006" then "103" // A/R
        else if [#"Account #"] = "100007" then "104" // Inventory Assets
	    else if [#"Account #"] = "100009" then "105" // Prepaid
	    else if List.Contains({"200001", "200002", "200003", "200004", "200006", "200007"}, [#"Account #"]) then "106" // Current Liabilities
	    else if [#"Account #"] = "100014" then "107" // Furniture & Equipment
	    else if [#"Account #"] = "100016" then "108" // Leasehold Improvements
	    else if [#"Account #"] = "100013" then "109" // Building Warehouse
	    else if [#"Account #"] = "100018" then "110" // Office Equipment
	    else if [#"Account #"] = "100019" then "111" // Vehicles
        else if [#"Account #"] = "100017" then "112" // New Warehouse
        else if [#"Account #"] = "100015" then "113" // House
        else if [#"Account #"] = "100012" then "114" // Accumulated Depreciation
        else if [#"Account #"] = "200009" then "115" // [REDACTED]
        else if [#"Account #"] = "200011" then "116" // [REDACTED]
        else if [#"Account #"] = "200012" then "117" // GM Financial
        else if [#"Account #"] = "200014" then "118" // [REDACTED]
        else if [#"Account #"] = "200015" then "119" // [REDACTED]
	    else if [#"Account #"] = "200016" then "120" // NP Yard Card
	    else if List.Contains({"300001", "300003", "300004"}, [#"Account #"]) then "121" // Members Draw/Retained Earnings
        else null),
    #"Changed Type2" = Table.TransformColumnTypes(#"Added Code to CF",{{"Level 1", type text}, {"Multiply Rules", Int64.Type}, {"Level 1 Order", Int64.Type}, {"Code to CF", type text}, {"Report Sheet", type text}}),
    #"Duplicated Column" = Table.DuplicateColumn(#"Changed Type2", "Account", "Account - Copy"),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Duplicated Column", "Account - Copy", Splitter.SplitTextByDelimiter(":", QuoteStyle.Csv), {"Account - Copy.1", "Account - Copy.2", "Account - Copy.3"}),
    #"Added Level 2 Custom" = Table.AddColumn(#"Split Column by Delimiter", "Level 2 Custom", each 
        if [#"Report Sheet"] = "Balance Sheet" and [#"Level 1"] = "Equity" then [#"Account - Copy.1"]
	    else if [#"Report Sheet"] = "Balance Sheet" and [#"Account - Copy.2"] <> null then [#"Account - Copy.2"]
        else if [#"Report Sheet"] = "Balance Sheet" then [#"Level 2"]
        else if [#"Level 1"] = "Income" and [#"Account - Copy.1"] = "Sales" and [#"Account - Copy.2"] = null then [#"Account - Copy.1"]
        else if [#"Level 1"] = "Income" and [#"Account - Copy.1"] = "Sales" then [#"Account - Copy.2"]
        else if [#"Level 1"] = "Income" then [#"Account - Copy.1"]
        else if [#"Level 1"] = "COGS" and [#"Account - Copy.1"] = "*Cost of Goods Sold" and [#"Account - Copy.2"] = null then [#"Account - Copy.1"]
        else if [#"Level 1"] = "COGS" and [#"Account - Copy.1"] = "*Cost of Goods Sold" then [#"Account - Copy.2"]
        else if [#"Level 1"] = "COGS" then [#"Account - Copy.1"]
        else [#"Account - Copy.1"]),
    #"Added Level 2 Conditional" = Table.AddColumn(#"Added Level 2 Custom", "Level 2 Conditional", each
        if [#"Account - Copy.1"] = "Sales" and [#"Level 2 Custom"] = "Conventional Honey" then "Sales - Conventional Honey"
        else if [#"Account - Copy.1"] = "Sales" and [#"Level 2 Custom"] = "Organic Honey" then "Sales - Organic Honey"
        else if [#"Account - Copy.1"] = "Sales" and [#"Level 2 Custom"] = "Regional Honey" then "Sales - Regional Honey"
        else if [#"Account - Copy.1"] = "*Cost of Goods Sold" and [#"Account - Copy.2"] = "Conventional Honey" then "*Cost of Goods Sold"
        else if [#"Account - Copy.1"] = "*Cost of Goods Sold" and [#"Account - Copy.2"] = "Organic Honey" then "*Cost of Goods Sold"
        else if [#"Account - Copy.1"] = "*Cost of Goods Sold" and [#"Account - Copy.2"] = "Regional Honey" then "*Cost of Goods Sold"
	    else if [#"Level 1"] = "Assets" and [#"Level 2 Custom"] = "Bank" then "Current Assets"
	    else if [#"Level 1"] = "Assets" and [#"Level 2 Custom"] = "Accounts receivable (A/R)" then "Current Assets"
	    else if [#"Level 1"] = "Assets" and [#"Level 2 Custom"] = "Other Current Assets" then "Current Assets"
        else if [#"Level 1"] = "Liabilities" and [#"Level 2"] = "Accounts payable (A/P)" then "Current Liabilities"
	    else if [#"Level 1"] = "Liabilities" and [#"Level 2"] = "Other Current Liabilities" then "Current Liabilities"
        else [#"Level 2 Custom"]),   
    #"Added Level 2 Order" = Table.AddColumn(#"Added Level 2 Conditional", "Level 2 Order", 
    each  
        if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Billable Expense Income" then "401"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Discounts given" then "402"  
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Markup" then "403"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "OTIF" then "404"   
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales" then "405" 
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales - Conventional Honey" then "406"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales - Organic Honey" then "407"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales - Regional Honey" then "408"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales - Other" then "409"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales Allowance, Discount & Ret" then "410"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales discount & credits" then "411"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Sales of Product Income" then "412"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Shipping Income" then "413"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Unapplied Cash Payment Income" then "414"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Unapplied Cash Payment Income-1" then "415"
        else if [#"Level 1"] = "Income" and [Level 2 Conditional] = "Uncategorized Income" then "416"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Cost of Goods Sold" then "501"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "*Cost of Goods Sold" then "502"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Conventional Honey" then "503"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Organic Honey" then "504"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Regional Honey" then "505"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Shipping" then "506"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Brokers'" then "507"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Caps and bottles" then "508"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Cost of Goods Sold - Other" then "509"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Freight" then "510"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "[REDACTED]" then "511"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "[REDACTED]" then "512"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "[REDACTED]" then "513"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Honey Bought" then "514"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Interest Expense -WOW" then "515"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Inventory Adjustments" then "516"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Inventory Shrinkage" then "517"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Miscellaneous Sales Credits" then "518"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Other Honey Cost" then "519"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Pallets" then "520"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Purchases - Syrup" then "521"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Purchases" then "522"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Slotting Fees" then "523"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Storage" then "524"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "Temp Labor Work" then "525"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "[REDACTED] Brokers" then "526"
        else if [#"Level 1"] = "COGS" and [Level 2 Conditional] = "WOW" then "527"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Ads" then "601"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Advertising and Promotion" then "602"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Automobile Expense" then "603"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Bad Debt" then "604"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Bonus" then "605"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Crystallized Honey" then "606"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Depreciation Expense" then "607"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Drug Screen" then "608"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Dues" then "609"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Educational" then "610"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Employee Benefit" then "611"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Forklift Lease" then "612"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Fuel" then "613"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "General & Administrative" then "614"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Interest Expense" then "615"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Liscensing Fees" then "616"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Meals and Entertainment" then "617"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Medical" then "618"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Miscellaneous Expense" then "619"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Production Loss" then "620"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Purchases-1" then "621"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Registration Fees" then "622"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Rental Business" then "623"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Salaries & Benefits" then "624"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Security" then "625"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Software" then "626"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Training" then "627"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Travel Expense" then "628"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Unapplied Cash Bill Payment Exp" then "629"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Unapplied Cash Bill Payment Expense" then "630"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Uncategorized Expense" then "631"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Uniforms" then "632"
        else if [#"Level 1"] = "Expenses" and [Level 2 Conditional] = "Website" then "633"
        else if [#"Level 1"] = "Other Income" and [Level 2 Conditional] = "Gain on Sale of Asset" then "701"
        else if [#"Level 1"] = "Other Income" and [Level 2 Conditional] = "Interest Income" then "702"
        else if [#"Level 1"] = "Other Expenses" and [Level 2 Conditional] = "Ask My Accountant" then "801"
        else if [#"Level 1"] = "Other Expenses" and [Level 2 Conditional] = "Charitable Donations" then "802"
        else if [#"Level 1"] = "Other Expenses" and [Level 2 Conditional] = "Reconciliation Discrepancies" then "803"
        else if [#"Level 1"] = "Assets" and [Level 2 Conditional] = "Current Assets" then "101"
        else if [#"Level 1"] = "Assets" and [Level 2 Conditional] = "Fixed Assets" then "102"
        else if [#"Level 1"] = "Assets" and [Level 2 Conditional] = "Other Assets" then "103"
        else if [#"Level 1"] = "Liabilities" and [Level 2 Conditional] = "Current Liabilities" then "201"
        else if [#"Level 1"] = "Liabilities" and [Level 2 Conditional] = "Long Term Liabilities" then "202"
        else if [#"Level 1"] = "Equity" and [Level 2 Conditional] = "Members Draw" then "301"
        else if [#"Level 1"] = "Equity" and [Level 2 Conditional] = "Opening Balance Equity" then "302"
        else if [#"Level 1"] = "Equity" and [Level 2 Conditional] = "Retained Earnings" then "303"
        else if [#"Level 1"] = "Equity" and [Level 2 Conditional] = "Unreconciled Adjustments (RE)" then "304"
        else if [#"Level 1"] = "Equity" and [Level 2 Conditional] = "Net Income" then "305"
        else null),
    #"Added Level 4 Custom" = Table.AddColumn(#"Added Level 2 Order", "Level 4 Custom", each
        if [#"Level 1"] = "Assets" and [#"Level 2"] = "Bank" then "Cash"
        else if [#"Level 1"] = "Assets" and [#"Level 4"] = "Prepaid Expenses" then "Other Current Assets"
        else if [#"Level 1"] = "Assets" and [#"Level 4"] = "Undeposited Funds" then "Other Current Assets"
        else if [#"Level 2 Conditional"] = "Fixed Assets" then [#"Account"]
	    else if [#"Level 2 Conditional"] = "Other Assets" then [#"Account"]
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" then [#"Account"]
        else if [#"Level 4"] = "Loan Payable" then "Other Current Liabilities"
	    else [#"Level 4"]),
    #"Added Level 4 Custom Order" = Table.AddColumn(#"Added Level 4 Custom", "Level 4 Custom Order", each  
        if [#"Level 2 Conditional"] = "Current Assets" and [#"Level 4 Custom"] = "Bank" then "101"
        else if [#"Level 2 Conditional"] = "Current Assets" and [#"Level 4 Custom"] = "Accounts Receivable (A/R)" then "102"
        else if [#"Level 2 Conditional"] = "Current Assets" and [#"Level 4 Custom"] = "Other Current Assets" then "103"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "Building-Warehouse" then "104"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "Furniture and Equipment" then "105"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "House" then "106"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "Leasehold Improvments" then "107"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "New Warehouse" then "108"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "Office Equipment" then "109"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "Vehicles" then "110"
        else if [#"Level 2 Conditional"] = "Fixed Assets" and [#"Level 4 Custom"] = "Accumulated Depreciation" then "111"
        else if [#"Level 2 Conditional"] = "Other Assets" and [#"Level 4 Custom"] = "Deposit" then "112"
        else if [#"Level 2 Conditional"] = "Other Assets" and [#"Level 4 Custom"] = "Due from [REDACTED]" then "113"
        else if [#"Level 2 Conditional"] = "Current Liabilities" and [#"Level 4 Custom"] = "Accounts Payable (A/P)" then "201"
        else if [#"Level 2 Conditional"] = "Current Liabilities" and [#"Level 4 Custom"] = "Other Current Liabilities" then "202"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "203"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "204"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "205"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "206"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "207"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "208"
        else if [#"Level 2 Conditional"] = "Long Term Liabilities" and [#"Level 4 Custom"] = "[REDACTED]" then "209"
        else null),
    #"Removed Other Columns1" = Table.SelectColumns(#"Added Level 4 Custom Order",{"Account #", "Account", "Level 2", "Level 4", "Description", "Level 1", "Report Sheet", "Multiply Rules", "Level 1 Order", "Code to CF", "Account - Copy.1", "Account - Copy.2", "Account - Copy.3", "Level 2 Conditional", "Level 2 Order", "Level 4 Custom", "Level 4 Custom Order"}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Removed Other Columns1",{{"Level 2 Conditional", type text}, {"Level 2 Order", Int64.Type}})
in
    #"Changed Type3"