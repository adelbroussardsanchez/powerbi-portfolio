let
    Source = CommonDataService.Database("[REDACTED].crm.dynamics.com"),
    dbo_msdyn_projecttask = Source{[Schema="dbo",Item="msdyn_projecttask"]}[Data],
    #"Added Custom" =
        Table.AddColumn(
            dbo_msdyn_projecttask,
            "Task Link",
            each
                "https://planner.cloud.microsoft/webui/mytasks/all/view/board/task/"
                & [msdyn_projecttaskid]
                & "?tid=[REDACTED]"
        ),
    #"Changed Type" =
        Table.TransformColumnTypes(#"Added Custom", {{"msdyn_finish", type date}})
in
    #"Changed Type"