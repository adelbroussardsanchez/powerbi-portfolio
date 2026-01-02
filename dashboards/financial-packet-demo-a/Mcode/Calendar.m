let
    StartDate = #date(2023,1,1),
    EndDate = Date.EndOfYear(DateTime.LocalNow()),
    DateList = List.Dates(StartDate, Number.From(EndDate) - Number.From(StartDate), #duration(1,0,0,0)),
    DateAsTable = Table.FromList(DateList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(DateAsTable,{{"Column1", "Date"}}),
    #"Changed TypeDate" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    Year = Table.AddColumn(#"Changed TypeDate", "Year", each Date.Year([Date])),
    MonthNum = Table.AddColumn(Year, "MonthNum", each Date.Month([Date])),
    MonthName = Table.AddColumn(MonthNum, "MonthName", each Date.ToText([Date], "MMMM")),
    MonthNameShort = Table.AddColumn(MonthName, "MonthNameShort", each Date.ToText([Date], "MMM")),
    YearMonth = Table.AddColumn(MonthNameShort, "YearMonth", each Date.ToText([Date], "yyyyMM")),
    Quarter = Table.AddColumn(YearMonth, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date]))),
    Period = Table.AddColumn(Quarter, "Period", each Date.ToText([Date], "yyMM")),
    PeriodName = Table.AddColumn(Period, "PeriodName", each Date.ToText([Date], "MMM yyyy")),
    OffsetYear = Table.AddColumn(PeriodName, "Offset_Year", each [Year] - Date.Year(DateTime.LocalNow())),
    OffsetMonth = Table.AddColumn(OffsetYear, "Offset_Period", each ([Year] - Date.Year(DateTime.LocalNow())) * 12 + ([MonthNum] - Date.Month(DateTime.LocalNow()))),
    Weekday = Table.AddColumn(OffsetMonth, "Weekday", each Date.DayOfWeek([Date], Day.Monday) + 1),
    WeekEnding = Table.AddColumn(Weekday, "WeekEnding", each Date.EndOfWeek([Date], Day.Monday)),
    OffsetWeek = Table.AddColumn(WeekEnding, "Offset_Week", each Duration.Days([WeekEnding] - DateTime.Date(Date.EndOfWeek(DateTime.LocalNow()))) / 7),
    OffsetQuarter = Table.AddColumn(OffsetWeek, "Offset_Quarter", each ([Year] - Date.Year(DateTime.LocalNow())) * 4 + (Date.QuarterOfYear([Date]) - Date.QuarterOfYear(DateTime.LocalNow()))),
    EndOfCurrentMonth = Table.AddColumn(OffsetQuarter, "EndOfCurrentMonth", each Date.EndOfMonth([Date])),
    EndOfPreviousMonth = Table.AddColumn(EndOfCurrentMonth, "EndOfPreviousMonth", each Date.EndOfMonth(Date.AddMonths([EndOfCurrentMonth], -1))),
    Month_Pos = Table.AddColumn(EndOfPreviousMonth, "Month_Pos", each [MonthNum] - Date.Month(DateTime.LocalNow())),
    #"Added Custom" = Table.AddColumn(Month_Pos, "MonthInQuarter", each if Number.Mod([MonthNum], 3) = 1 then 1
else if Number.Mod([MonthNum], 3) = 2 then 2
else if Number.Mod([MonthNum], 3) = 0 then 3
else null),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom",{{"Offset_Week", Int64.Type}, {"WeekEnding", type date}, {"Weekday", Int64.Type}, {"Offset_Period", Int64.Type}, {"Offset_Year", Int64.Type}, {"Period", type text}, {"Quarter", type text}, {"YearMonth", type text}, {"MonthNameShort", type text}, {"MonthName", type text}, {"MonthNum", Int64.Type}, {"Year", Int64.Type}, {"EndOfCurrentMonth", type date}, {"EndOfPreviousMonth", type date}, {"PeriodName", type text}, {"Offset_Quarter", Int64.Type}, {"Month_Pos", Int64.Type}, {"MonthInQuarter", Int64.Type}})
in
    #"Changed Type"