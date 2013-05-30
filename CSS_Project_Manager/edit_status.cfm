<cfinclude template="header.cfm">
<!--Allow only Role 1 to see screen for assign or edit -->
<cfif '#check_role.Role#' NEQ "" AND '#check_role.Role#' EQ 1>


<tr height="10px"><td></td></tr>
<tr height="20px">
<td align="left"><span class="status_head">Ticket Update Dashboard</span> &nbsp; <cfoutput query="Get_project_detail"><a href="detail.cfm?ID=#ProjectID#">[Ticket Detail]</a></cfoutput></td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>Use this dashboard to assign a new ticket, assign another owner to an existing ticket, and / or to update the status of an existing ticket.</td></tr>
<tr><td>


<!--- ========== (start) IF ASSIGN FORM USED === action section ================= --->
<cfif IsDefined ("FORM.Update") AND IsDefined("URL.ID")>
<!--- Make ticket "Assigned" status --->
<cfquery name="Edit_Ticket" datasource="#request.dsn#">
	UPDATE T_Project_Manager
		SET 
		w_fname = <cfif FORM.WorkerName NEQ "">'#Trim(FORM.WorkerName)#'<cfelse>NULL</cfif>,
		status = '2'
	WHERE ProjectID = #URL.ID#
</cfquery>
	<p style="font:Arial, Helvetica, sans-serif; font-size:12px; color:#993333;">This ticket has been assigned and an email has been sent to <cfoutput>#FORM.WorkerName#</cfoutput>.</p>
<!--- /UPDATE CODE --->
</td></td></table>

<cfquery name="Get_Worker_Info" datasource="#Request.dsn#">
    SELECT *
    FROM T_CSS_Staff
    WHERE Name = '#Trim(FORM.WorkerName)#'
</cfquery>

<cfquery name="Get_Ticket_Info" datasource="#Request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    WHERE ProjectID = #URL.ID#
</cfquery>

<!--- send an email to the new owner 1 (start) --->
<cfmail to="#Get_Worker_Info.Email#@psu.edu" from="#cgi.http_remote_user#@psu.edu" subject="Project Assigned: #Get_Ticket_Info.ProjectID# #Get_Ticket_Info.ptitle# " type="html">
<cfoutput>#Get_Worker_Info.Name#</cfoutput>, You have been assigned a ticket that originated in the Project Tracker. The details for this project are as follows:
<br />
<br />
<table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Project Ticket Details:</b></span></td></tr>
<tr><td width="250px"><strong>Requested By:</strong></td><td width="450px"><a href="mailto:#Get_Ticket_Info.userEmail#">#Get_Ticket_Info.userFname# #Get_Ticket_Info.userLname#</a></td></tr>
<tr><td><strong>Team:</strong></td><td>#Get_Ticket_Info.Team_Name#</td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Ticket_Info.ProjectID#</td></tr>
<tr><td><b>Submitted On:</b></td><td>#DateFormat(Get_Ticket_Info.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#Get_Ticket_Info.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#Get_Ticket_Info.pscope#</td></tr>
<tr><td><strong>Title:</strong></td><td>#Get_Ticket_Info.ptitle#</td></tr>
<tr><td><strong>Description:</strong></td><td>#Get_Ticket_Info.pdesc#</td></tr> 
<tr><td><strong>Requested Due Date:</strong></td><td>#Get_Ticket_Info.pdue#</td></tr></table>
<br /><br />
To view and / or place this ticket into development status, please <a href="https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Ticket_Info.ProjectID#">sign in to the Project Tracker</a>.
<br /><br />
If you have any trouble clicking on the live link above, please copy and paste this url into your web browser:<br />
https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Ticket_Info.ProjectID#
<br /><br />
</cfmail>
<!--- send an email to the new owner (end) --->


<!--- GO TO CURRENT PAGE IN 0 SECONDS --->
<cfheader name="Refresh" value="4; URL=edit_status.cfm?ID=#Get_Ticket_Info.ProjectID#">

<cfabort>
</cfif>
<!--- ========== (end) IF ASSIGN FORM USED === action section ================= --->









<!--- ========== (start) IF UPDATE STATUS FORM USED === action section ================= --->
<cfif IsDefined ("FORM.Update_status") AND IsDefined("URL.ID")>
<!--- IF IS DEFINED,THEN UPDATE RECORD --->
<cfquery name="Edit_Ticket" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET status = '#Current_Status#'
	WHERE ProjectID = #URL.ID#;
</cfquery>

<cfquery name="Update_Status" datasource="#Request.dsn#">
    SELECT *
    FROM T_Statuses
    WHERE Status_ID = '#Trim(FORM.Current_Status)#';
</cfquery>


<!--- email all owners --->

<!--- Get owner 1 email --->
<cfquery name="Get_owner_Email" datasource="#request.dsn#">
	SELECT Email_full
	FROM T_CSS_Staff
	WHERE Name = '#Trim(Get_Project_detail.w_fname)#';
</cfquery>


<!--- Get owner 2 email --->
<cfquery name="Get_owner2_Email" datasource="#request.dsn#">
	SELECT Email_full
	FROM T_CSS_Staff
	WHERE Name = '#Trim(Get_Project_detail.owner2)#';
</cfquery>


<!--- Get owner 3 email --->
<cfquery name="Get_owner3_Email" datasource="#request.dsn#">
	SELECT Email_full
	FROM T_CSS_Staff
	WHERE Name = '#Trim(Get_Project_detail.owner3)#';
</cfquery>


<!--- Get owner 4 email --->
<cfquery name="Get_owner4_Email" datasource="#request.dsn#">
	SELECT Email_full
	FROM T_CSS_Staff
	WHERE Name = '#Trim(Get_Project_detail.owner4)#';
</cfquery>

<!--- Get any notes for email --->
<cfquery name="Get_notes" datasource="#request.dsn#">
SELECT * 
FROM T_Notes
Where Ticket_ID = #URL.ID#
ORDER BY n_date DESC
</cfquery>

<!--- Get status name for email --->
<cfquery name="Get_status_name" datasource="#Request.dsn#">
    SELECT *
    FROM T_Statuses
    WHERE Status_ID = '#Trim(Get_Project_detail.status)#';
</cfquery>


<cfif '#Get_owner2_Email.Email_full#' NEQ ""><cfset ownertwo = ",#Get_owner2_Email.Email_full#"><cfelse>
<cfset ownertwo = ""></cfif>

<cfif '#Get_owner3_Email.Email_full#' NEQ ""><cfset ownerthree = ",#Get_owner3_Email.Email_full#"><cfelse>
<cfset ownerthree = ""></cfif>

<cfif '#Get_owner4_Email.Email_full#' NEQ ""><cfset ownerfour = ",#Get_owner4_Email.Email_full#"><cfelse>
<cfset ownerfour = ""></cfif>

<cfset all_owners = "#Get_owner_Email.Email_full##ownertwo##ownerthree##ownerfour#,#Get_Project_detail.userEmail#">

<cfoutput>Email to: #all_owners#</cfoutput>

<cfmail to="#all_owners#" from="#cgi.http_remote_user#@psu.edu" type="html" subject="Ticket #Get_Project_detail.ProjectID# updated to #Update_Status.status#">
The status of ticket <b>#Get_Project_detail.ProjectID#: #Get_Project_detail.ptitle#</b> has been updated to <b>#Update_Status.status#</b>.<br /><br />

<table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Ticket Details:</b></span></td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Project_detail.ProjectID#</td></tr>
<tr><td><strong>Title:</strong></td><td>#Get_Project_detail.ptitle#</td></tr>
<tr><td><strong>Status:</strong></td><td>#Update_Status.status#</td></tr>

<tr><td width="250px"><strong>Requested By:</strong></td><td width="450px"><a href="mailto:#Get_Project_detail.userEmail#">#Get_Project_detail.userFname# #Get_Project_detail.userLname#</a></td></tr>
<tr><td><strong>Team:</strong></td><td>#Get_Project_detail.Team_Name#</td></tr>

<tr><td><b>Submitted On:</b></td><td>#DateFormat(Get_Project_detail.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#Get_Project_detail.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#Get_Project_detail.pscope#</td></tr>

<tr><td><strong>Description:</strong></td><td>#Get_Project_detail.pdesc#</td></tr> 
<tr><td><strong>Requested Due Date:</strong></td><td>#Get_Project_detail.pdue#</td></tr>


<!--- include the notes, yo! --->
<tr><td colspan="2" bgcolor="##999999"><strong>Notes:</strong></td></tr>

<cfif '#Get_notes.pnotes#' NEQ "">
<tr><td colspan="2">#Get_notes.pnotes# <br />
#DateFormat(Get_notes.n_date, "dddd MM/DD/YY")#, #TimeFormat(Get_notes.n_date, 'h:mm tt')#</td></tr>

<cfelse>
<tr><td colspan="2">There are no notes at this time.</td></tr>
</cfif>
</table>
<!--- end: include the notes, yo! --->

<br /><br />
To view this ticket please <a href="https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Project_detail.ProjectID#">view the Project Tracker</a>.
<br /><br />
If you have any trouble clicking on the live link above, please copy and paste this url into your web browser:<br />
https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Project_detail.ProjectID#
<br /><br />
</cfmail>
<!--- end of owners email --->



<!--- start: if ticket status changed to "Proof/Edit", Add Tammy as an owner AND auto send Tammy an email informing her this ticket needs proofed/edited --->
<cfif #FORM.Current_Status# EQ 5>
<!--- add Tammy as owner--->

<cfif '#Get_Project_detail.w_fname#' EQ ''>
<cfquery name="Add_tjd6" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		w_fname = 'Tammy'
	WHERE ProjectID = #URL.ID#
</cfquery>

<cfelseif '#Get_Project_detail.w_fname#' NEQ '' AND '#Get_Project_detail.owner2#' EQ ''>
<cfquery name="Add_tjd6" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		owner2 = 'Tammy'
	WHERE ProjectID = #URL.ID#
</cfquery>

<cfelseif '#Get_Project_detail.owner2#' NEQ '' AND '#Get_Project_detail.owner3#' EQ ''>
<cfquery name="Add_tjd6" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		owner3 = 'Tammy'
	WHERE ProjectID = #URL.ID#
</cfquery>

<cfelseif '#Get_Project_detail.owner3#' NEQ '' AND '#Get_Project_detail.owner4#' EQ ''>
<cfquery name="Add_tjd6" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		owner4 = 'Tammy'
	WHERE ProjectID = #URL.ID#
</cfquery>
</cfif>




<!---send her the email--->

<cfmail to="tjd6@psu.edu" from="#cgi.http_remote_user#@psu.edu" type="html" subject="Notice of PROOF/EDIT: Ticket  #Get_Project_detail.ProjectID#">

Tammy,<br />
Ticket <b>#Get_Project_detail.ProjectID#: #Get_Project_detail.ptitle#</b> has been updated to <b>#Update_Status.status#</b>. This is an automated notice. Please review the ticket details below to see if it needs to be proofed and/or edited. <br /><br />
<b>Concerning Web based tickets only:</b> Generally, only public web edits with large amounts of content need your attention. The rest of the web-based tickets (public web with small changes and all intranet content) will be proofed by the requester. Thanks, you're the coolest.<br /><br />

<table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Ticket Details:</b></span></td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Project_detail.ProjectID#</td></tr>
<tr><td><strong>Title:</strong></td><td>#Get_Project_detail.ptitle#</td></tr>
<tr><td><strong>Status:</strong></td><td>#Update_Status.status#</td></tr>

<tr><td width="250px"><strong>Requested By:</strong></td><td width="450px"><a href="mailto:#Get_Project_detail.userEmail#">#Get_Project_detail.userFname# #Get_Project_detail.userLname#</a></td></tr>
<tr><td width="250px"><strong>Filled By:</strong></td><td width="450px">#Get_Project_detail.filled_by#</td></tr>
<tr><td><strong>Team:</strong></td><td>#Get_Project_detail.Team_Name#</td></tr>

<tr><td><b>Submitted On:</b></td><td>#DateFormat(Get_Project_detail.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#Get_Project_detail.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#Get_Project_detail.pscope#</td></tr>

<tr><td><strong>Description:</strong></td><td>#Get_Project_detail.pdesc#</td></tr> 
<tr><td><strong>Requested Due Date:</strong></td><td>#Get_Project_detail.pdue#</td></tr>


<!--- include the notes, yo! --->
<tr><td colspan="2" bgcolor="##999999"><strong>Notes:</strong></td></tr>

<cfif '#Get_notes.pnotes#' NEQ "">
<tr><td colspan="2">#Get_notes.pnotes# <br />
#DateFormat(Get_notes.n_date, "dddd MM/DD/YY")#, #TimeFormat(Get_notes.n_date, 'h:mm tt')#</td></tr>
<cfelse>
<tr><td colspan="2">There are no notes at this time.</td></tr>
</cfif>
</table>
<!--- end: include the notes, yo! --->

<br /><br />
To view this ticket please <a href="https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Project_detail.ProjectID#">view the Project Tracker</a>.
<br /><br />
If you have any trouble clicking on the live link above, please copy and paste this url into your web browser:<br />
https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Project_detail.ProjectID#
<br /><br />
</cfmail>
</cfif>
<!--- END: if ticket status changed to "Proof/Edit", auto send giovanna an email informing her this ticket needs proofed/edited --->



<!--- screen message displayed --->
<p style="font:Arial, Helvetica, sans-serif; font-size:12px; color:#993333;">This ticket status has been updated to <b><cfoutput>#Update_Status.status#</cfoutput></b>. The owner(s) have been notified.</p>
<!--- /UPDATE CODE --->
</td></td></table>

<!--- GO TO CURRENT PAGE IN 0 SECONDS --->
<cfheader name="Refresh" value="3; URL=edit_status.cfm?ID=#Get_Project_detail.ProjectID#">
<cfabort>
</cfif>
<!--- ========== (end) IF UPDATE STATUS FORM USED === action section ================= --->








<!--- ========== (start) IF ASSIGN multiple users FORM USED === action section ================= --->
<cfif IsDefined ("FORM.update_multiple_users") AND IsDefined("URL.ID")>
<!--- add more owners, dont change status --->


<cfif '#Assign_project.w_fname#' EQ ''>
<cfquery name="Add_more_owners" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		w_fname = <cfif FORM.WorkerName NEQ "">'#Trim(FORM.WorkerName)#'<cfelse>NULL</cfif>
	WHERE ProjectID = #URL.ID#
</cfquery>

<cfelseif '#Assign_project.w_fname#' NEQ '' AND '#Assign_project.owner2#' EQ ''>
<cfquery name="Add_more_owners" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		owner2 = <cfif FORM.WorkerName NEQ "">'#Trim(FORM.WorkerName)#'<cfelse>NULL</cfif>
	WHERE ProjectID = #URL.ID#
</cfquery>

<cfelseif '#Assign_project.owner2#' NEQ '' AND '#Assign_project.owner3#' EQ ''>
<cfquery name="Add_more_owners" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		owner3 = <cfif FORM.WorkerName NEQ "">'#Trim(FORM.WorkerName)#'<cfelse>NULL</cfif>
	WHERE ProjectID = #URL.ID#
</cfquery>

<cfelseif '#Assign_project.owner3#' NEQ '' AND '#Assign_project.owner4#' EQ ''>
<cfquery name="Add_more_owners" datasource="#request.dsn#">
	UPDATE T_Project_Manager
	SET 
		owner4 = <cfif FORM.WorkerName NEQ "">'#Trim(FORM.WorkerName)#'<cfelse>NULL</cfif>
	WHERE ProjectID = #URL.ID#
</cfquery>
</cfif>


<p style="font:Arial, Helvetica, sans-serif; font-size:12px; color:#993333;"><cfoutput>#FORM.WorkerName#</cfoutput> has been added as another owner on this ticket and has been notified by email.</p>
<!--- /UPDATE CODE --->
</td></td></table>

<cfquery name="Get_Worker_Info" datasource="#Request.dsn#">
    SELECT *
    FROM T_CSS_Staff
    WHERE Name = '#Trim(FORM.WorkerName)#'
</cfquery>

<cfquery name="Get_Ticket_Info" datasource="#Request.dsn#">
    SELECT * 
    FROM T_Project_Manager
    WHERE ProjectID = #URL.ID#
</cfquery>

<!--- Get any notes for email --->
<cfquery name="Get_notes" datasource="#request.dsn#">
SELECT * 
FROM T_Notes
Where Ticket_ID = #URL.ID#
ORDER BY n_date DESC
</cfquery>

<!--- Get status name for email --->
<cfquery name="Get_status_name" datasource="#Request.dsn#">
    SELECT *
    FROM T_Statuses
    WHERE Status_ID = '#Trim(Get_Project_detail.status)#';
</cfquery>


<!--- send an email to the new owner multiple (start) --->
<cfmail to="#Get_Worker_Info.Email#@psu.edu" from="#cgi.http_remote_user#@psu.edu" subject="Added As Owner: #Get_Ticket_Info.ProjectID# #Get_Ticket_Info.ptitle# " type="html">
<cfoutput>#Get_Worker_Info.Name#</cfoutput>, You have been added as an owner on a Project Tracker ticket:
<br />
<br />
<table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Ticket Details:</b></span></td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Project_detail.ProjectID#</td></tr>
<tr><td><strong>Title:</strong></td><td>#Get_Project_detail.ptitle#</td></tr>
<tr><td><strong>Status:</strong></td><td>#Get_status_name.status#</td></tr>

<tr><td width="250px"><strong>Requested By:</strong></td><td width="450px"><a href="mailto:#Get_Project_detail.userEmail#">#Get_Project_detail.userFname# #Get_Project_detail.userLname#</a></td></tr>
<tr><td><strong>Team:</strong></td><td>#Get_Project_detail.Team_Name#</td></tr>

<tr><td><b>Submitted On:</b></td><td>#DateFormat(Get_Project_detail.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#Get_Project_detail.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#Get_Project_detail.pscope#</td></tr>

<tr><td><strong>Description:</strong></td><td>#Get_Project_detail.pdesc#</td></tr> 
<tr><td><strong>Requested Due Date:</strong></td><td>#Get_Project_detail.pdue#</td></tr>


<!--- include the notes, yo! --->
<tr><td colspan="2" bgcolor="##999999"><strong>Notes:</strong></td></tr>

<!---<cfif '#Get_notes.pnotes#' NEQ "">
<tr><td colspan="2">#Get_notes.pnotes# <br />
#DateFormat(Get_notes.n_date, "dddd MM/DD/YY")#, #TimeFormat(Get_notes.n_date, 'h:mm tt')#</td></tr>
<cfelse>
<tr><td colspan="2">There are no notes at this time.</td></tr>
</cfif> --->

<cfoutput>
<tr><td colspan="2" align="left" valign="top" style="font-size: 10px;">
#Get_notes.pnotes# <br />
#DateFormat(Get_notes.n_date, "dddd MM/DD/YY")#, #TimeFormat(Get_notes.n_date, 'h:mm tt')#</td></tr>
</cfoutput>

<cfif #Get_notes.Note_ID# EQ "">
<tr><td align="left" valign="top" style="font-size: 10px;">
There are no notes at this time for this ticket.</td></tr>
</cfif>

</table>
<br /><br />
To view and / or place this ticket into development status, please <a href="https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Ticket_Info.ProjectID#">sign in to the Project Tracker</a>.
<br /><br />
If you have any trouble clicking on the live link above, please copy and paste this url into your web browser:<br />
https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/detail.cfm?ID=#Get_Ticket_Info.ProjectID#
<br /><br />
</cfmail>
<!--- send an email to the new owner 2 (end) --->


<!--- GO TO CURRENT PAGE IN 0 SECONDS --->
<cfheader name="Refresh" value="3; URL=edit_status.cfm?ID=#Get_Ticket_Info.ProjectID#">

<cfabort>
</cfif>
<!--- ========== (end) IF ASSIGN Multiple users FORM USED === action section ================= --->







<cfquery name="Get_Status_of_current" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = '#Assign_project.Status#'
</cfquery>

<cfoutput query="Assign_project">
<fieldset border="1px" bordercolor="##006633" style="background:##ffffff; text-align:left; padding:10px; font-family:Trebuchet, Tahoma, Geneva, sans-serif;  font-size:11px; line-height:20px; width:600px">
<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: ##3399FF; font-weight: bold">Ticket No. #ProjectID#</span> </legend>

<strong>Title</strong>: #ptitle#<br />
<strong>Description</strong>: #pdesc#<br />
<strong>Requested By</strong>: #userFname# #userLname#<br />
<strong>Due Date</strong>: #pdue#<br />
<strong>Submitted On </strong>: #DateFormat(s_date, "MM/DD/YY")#<br />
<strong>Status</strong>: #Get_Status_of_current.Status#<br />

<cfif '#Assign_project.w_fname#' NEQ '' AND  '#Assign_project.w_fname#' NEQ 'NA'><strong>Owner</strong>: #w_fname# <a href="delete_owner.cfm?ID=#Get_Project_detail.ProjectID#&Owner=1" title="Delete Owner 1">[Delete]</a><br /></cfif>

<cfif '#Assign_project.owner2#' NEQ ''><strong>Owner</strong>: #owner2#  
<a href="delete_owner.cfm?ID=#Get_Project_detail.ProjectID#&Owner=2" title="Delete Owner 2">[Delete]</a><br /></cfif>

<cfif '#Assign_project.owner3#' NEQ ''><strong>Owner</strong>: #owner3#  
<a href="delete_owner.cfm?ID=#Get_Project_detail.ProjectID#&Owner=3" title="Delete Owner 3">[Delete]</a><br /></cfif>

<cfif '#Assign_project.owner4#' NEQ ''><strong>Owner</strong>: #owner4#  
<a href="delete_owner.cfm?ID=#Get_Project_detail.ProjectID#&Owner=4" title="Delete Owner 4">[Delete]</a><br /></cfif>
<span class="note">Each ticket can have up to four (4) owners assigned to it.</span>

</fieldset>
</cfoutput>


<!---use this: <cfif '#w_fname#' NEQ ''>#w_fname#<cfelse>Not yet assigned. &nbsp; <a href="edit_status.cfm?ID=#ProjectID#" title="Assign Ticket">[Assign]</a></cfif> --->

<cfif #Get_Project_detail.status# EQ 1>
<cfoutput query="Assign_project">
<fieldset border="1px" bordercolor="##006633" style="background:##ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:25px; width:600px">
<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: ##3399FF; font-weight: bold">Assign Owner No. 1</span></legend>
<strong>Owner</strong>: N/A<br>

<cfquery name="Get_Assignee" datasource="#Request.dsn#">
SELECT *
FROM T_CSS_Staff
</cfquery>


<!--- start - Populate a drop down menu with worker names --->
<form action="#cgi.SCRIPT_NAME#?ID=#URL.ID#" method="post" name="Assign_Ticket">
<select name="WorkerName">
<cfloop query="Get_Assignee">
<option value="#Name#">#Name#</option>
</cfloop>
</select>
<input type="submit" name="update" value="Assign" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;">
</form>
<!--- end - Populate a drop down menu with worker names --->
</fieldset>
</cfoutput>



<cfelse>

<cfquery name="Get_Status_of_current" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = '#Assign_project.Status#'
</cfquery>

<cfoutput query="Get_Project_detail">
<fieldset border="1px" bordercolor="##006633" style="background:##ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:25px; width:600px">
<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: ##3399FF; font-weight: bold">Update Ticket Status</span> </legend>
<strong>Current Status</strong>: #Get_Status_of_current.Status#<br>
<span class="note"><i>Change the status...</i></span>
<cfquery name="Get_Statuses" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
</cfquery>



<!--- start - Populate a drop down menu with status names --->
<form action="#cgi.SCRIPT_NAME#?ID=#URL.ID#" method="post" name="Edit_Ticket_Status">
<select name="Current_Status">
<cfloop query="Get_Statuses">
<option value="#Status_ID#">#Status#</option>
</cfloop>
</select>
<input type="submit" name="update_status" value="Update" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;" onClick="return confirmSubmit()">
</form>
<!--- end - Populate a drop down menu with status names --->
</fieldset>
</cfoutput>


<!--- start - Add another owner --->
<cfif '#Assign_project.owner2#' EQ '' OR '#Assign_project.owner3#' EQ '' OR '#Assign_project.owner4#' EQ ''>
<cfoutput query="Assign_project">
<fieldset border="1px" bordercolor="##006633" style="background:##ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:25px; width:600px">
<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: ##3399FF; font-weight: bold">Assign Multiple Owner</span></legend>

<cfquery name="Get_Assignee" datasource="#Request.dsn#">
SELECT *
FROM T_CSS_Staff
</cfquery>

<!--- start - Populate a drop down menu with worker names --->
<form action="#cgi.SCRIPT_NAME#?ID=#URL.ID#" method="post" name="Assign_Multiple_Owner">
<select name="WorkerName">
<cfloop query="Get_Assignee">
<option value="#Name#">#Name#</option>
</cfloop>
</select>
<input type="submit" name="update_multiple_users" value="Assign" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;">
</form>
<!--- end - Populate a drop down menu with worker names --->
</fieldset>
</cfoutput>
</cfif>
<!--- end - Add another owner --->

</cfif>


<cfelse>

<cflocation url="insert.cfm" addtoken="no">

</cfif>