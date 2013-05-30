
<!--- GET 'EM ALL --->

<cfquery name="Get_projects_all" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    ORDER BY ProjectID DESC
</cfquery>


<!--- GET BY STATUS (EXP) --->

<cfif IsDefined ("URL.Status")>
<cfquery name="Get_projects_exp" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    Where status = '#URL.Status#'
    ORDER BY ProjectID DESC
</cfquery>
</cfif>


<!--- GET BY ProjectID to Assign or Change Status --->

<cfif IsDefined ("URL.ID")>
<cfquery name="Assign_project" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    Where ProjectID = '#URL.ID#'
</cfquery>

<cfquery name="Get_Project_detail" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    Where ProjectID = '#URL.ID#'
</cfquery>

</cfif>


<!--- GET for display recordcount in header --->

<cfquery name="Get_projects_new" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    Where status = '1'
    ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_assigned" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    Where status = '2'
    ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_design" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '3'
	ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_development" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '4'
	ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_proof" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '5'
	ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_printer" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '6'
	ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_complete" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '7'
	ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_closed" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '8'
	ORDER BY ProjectID DESC
</cfquery>

<cfquery name="Get_projects_def" datasource="#request.dsn#">
	SELECT * 
	FROM T_Project_Manager
	Where status = '9'
	ORDER BY ProjectID DESC
</cfquery>


<cfquery name="check_role" datasource="#request.dsn#">
	SELECT Role
    FROM T_CSS_Staff
    WHERE Email = '#cgi.http_remote_user#'
</cfquery>


