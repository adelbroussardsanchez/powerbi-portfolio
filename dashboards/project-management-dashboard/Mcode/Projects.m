let
    Source = CommonDataService.Database("[REDACTED]d.crm.dynamics.com"),
    dbo_msdyn_project = Source{[Schema="dbo",Item="msdyn_project"]}[Data],
    #"Removed Other Columns" = Table.SelectColumns(dbo_msdyn_project,{"msdyn_projectid", "msdyn_subject", "msdyn_projectmanager", "msdyn_projectmanagername"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"msdyn_projectid", "ProjectID"}, {"msdyn_subject", "ProjectName"}, {"msdyn_projectmanager", "ProjectManagerID"}, {"msdyn_projectmanagername", "ProjectManagerName"}})
in
    #"Renamed Columns"