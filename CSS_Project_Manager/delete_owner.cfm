
<cfif '#URL.Owner#' NEQ '' AND '#URL.Owner#' EQ 1>
<cfquery name="Delete_owner_one" datasource="#request.dsn#">
    UPDATE T_Project_Manager 
    SET w_fname = NULL
    WHERE ProjectID = '#URL.ID#'
</cfquery>

<cfquery name="Get_Project_detail" datasource="#request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    Where ProjectID = '#URL.ID#'
</cfquery>

<cfif '#Get_Project_detail.owner2#' EQ '' AND  '#Get_Project_detail.owner3#' EQ '' AND  '#Get_Project_detail.owner4#' EQ ''>
<cfquery name="Status_to_new" datasource="#request.dsn#">
    UPDATE T_Project_Manager 
    SET status = 1
    WHERE ProjectID = '#URL.ID#'
</cfquery>
</cfif>
</cfif>



<cfif '#URL.Owner#' NEQ '' AND '#URL.Owner#' EQ 2>
<cfquery name="Delete_owner_two" datasource="#request.dsn#">
    UPDATE T_Project_Manager 
    SET owner2 = NULL
    WHERE ProjectID = '#URL.ID#'
</cfquery>
</cfif>

<cfif '#URL.Owner#' NEQ '' AND '#URL.Owner#' EQ 3>
<cfquery name="Delete_owner_three" datasource="#request.dsn#">
    UPDATE T_Project_Manager 
    SET owner3 = NULL
    WHERE ProjectID = '#URL.ID#'
</cfquery>
</cfif>

<cfif '#URL.Owner#' NEQ '' AND '#URL.Owner#' EQ 4>
<cfquery name="Delete_owner_four" datasource="#request.dsn#">
    UPDATE T_Project_Manager 
    SET owner4 = NULL
    WHERE ProjectID = '#URL.ID#'
</cfquery>
</cfif>

This owner has been removed from this ticket.





<!--- GO TO CURRENT PAGE IN 0 SECONDS --->
<cfheader name="Refresh" value="3; URL=edit_status.cfm?ID=#URL.ID#">