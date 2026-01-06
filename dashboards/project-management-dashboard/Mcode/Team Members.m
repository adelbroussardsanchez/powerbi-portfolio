let
    Source = CommonDataService.Database("[REDACTED].dynamics.com"),
    dbo_bookableresource = Source{[Schema="dbo",Item="bookableresource"]}[Data],
    #"Removed Other Columns" = Table.SelectColumns(dbo_bookableresource,{"bookableresourceid", "name"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"bookableresourceid", "ResourceID"}, {"name", "ResourceName"}})
in
    #"Renamed Columns"