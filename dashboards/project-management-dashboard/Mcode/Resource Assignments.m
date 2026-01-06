let
    Source = CommonDataService.Database("[REDACTED].dynamics.com"),
    dbo_msdyn_resourceassignment = Source{[Schema="dbo",Item="msdyn_resourceassignment"]}[Data],
    #"Removed Other Columns" = Table.SelectColumns(dbo_msdyn_resourceassignment,{"msdyn_resourceassignmentid", "ownerid", "owneridname", "owningbusinessunit", "owningteam", "owningbusinessunitname", "msdyn_bookableresourceid", "msdyn_effort", "msdyn_effortcompleted", "msdyn_effortremaining", "msdyn_finish", "msdyn_plannedwork", "msdyn_projectid", "msdyn_projectteamid", "msdyn_start", "msdyn_taskid", "msdyn_bookableresourceidname", "msdyn_projectidname", "msdyn_taskidname", "msdyn_projectteamidname", "asyncoperation", "bookableresource", "businessunit", "msdyn_project", "msdyn_projecttask", "msdyn_projectteam", "processsession", "systemuser(msdyn_userresourceid)", "systemuser(owninguser)", "team"})
in
    #"Removed Other Columns"