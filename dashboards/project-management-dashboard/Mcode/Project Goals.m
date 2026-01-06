let
    Source = CommonDataService.Database("[REDACTED].crm.dynamics.com"),
    dbo_msdyn_projectgoal = Source{[Schema="dbo",Item="msdyn_projectgoal"]}[Data],
    #"Removed Other Columns" = Table.SelectColumns(dbo_msdyn_projectgoal,{"msdyn_projectgoalid", "createdon", "ownerid", "owneridname", "owningteam", "msdyn_name", "msdyn_end", "msdyn_priority", "msdyn_priorityname", "msdyn_projectid", "msdyn_start", "msdyn_status", "msdyn_statusname", "msdyn_projectidname", "team"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Other Columns",{{"msdyn_projectgoalid", "ProjectGoalId"}, {"createdon", "CreatedOnDate"}, {"ownerid", "OwnerId"}, {"owneridname", "OwnerIdName"}, {"owningteam", "OwningTeam"}, {"msdyn_name", "GoalDescription"}, {"msdyn_end", "EndDate"}, {"msdyn_priority", "PriorityCode"}, {"msdyn_priorityname", "PriorityName"}, {"msdyn_projectid", "ProjectId"}, {"msdyn_start", "StartDate"}, {"msdyn_status", "StatusCode"}, {"msdyn_statusname", "StatusName"}, {"msdyn_projectidname", "ProjectName"}, {"team", "TeamTable"}})
in
    #"Renamed Columns"