<cfquery name="Get_projects_new" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
Where status = '1'
ORDER BY ProjectID DESC
</cfquery>

<cfif IsDefined ("URL.ID")>
<cfquery name="Assign_project" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
Where ProjectID = #URL.ID#
</cfquery>
</cfif>

<cfquery name="Get_projects_assigned" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
Where status = '2'
ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_development" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
Where status = '3'
ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_complete" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
Where status = '4'
ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_closed" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
Where status = '5'
ORDER BY ProjectID DESC
</cfquery>

