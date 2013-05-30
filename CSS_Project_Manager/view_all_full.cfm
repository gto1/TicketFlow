<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">All Tickets</td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>This is a table showing all of the tickets in full view. You may view all <cfoutput query="Get_projects_all" maxrows="1">#Get_projects_all.recordcount#</cfoutput> of the tickets. <!--by owner: 

<a href="view_all_owner.cfm?Owner=Brooke">Brooke</a> | 
<a href="view_all_owner.cfm?Owner=Giovanna">Giovanna</a> | 
<a href="view_all_owner.cfm?Owner=Greg">Greg</a> | 
<a href="view_all_owner.cfm?Owner=Tammy">Tammy</a> | 
<a href="view_all_owner.cfm?Owner=Tina">Tina</a> |
<a href="view_all_owner.cfm?Owner=Kyle">Kyle</a> -->

<cfif '#Get_projects_all.recordcount#' EQ 0><br><br>
<p style="font-size:12px"><span style="font-weight: bold">Note</span>: Currently, there are no records in this table.</p>
<cfelse></td></tr>
</table>

<table width="950px" border="1px" bordercolor="#CCCCCC" cellpadding="5px" cellspacing="0px">

<cfoutput query="Get_projects_all">
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))# style="font-size: 10px;">
<td align="left" valign="top" style="font-family:Arial, Helvetica, sans-serif; font-size: 11px; line-height: 16px;">
<b>#ProjectID# - #ptitle#</b> &nbsp; &nbsp; 

<cfquery name="Get_Statuses" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = #Get_projects_all.status#
</cfquery>
Status: <span style="color:##00f;">#Get_Statuses.Status#</span><br />


<p align="justify">#pdesc#</p>
<b>Requested by:</b> #userFname# #userLname#<br />
<b>Deadline:</b> #pdue#<br />
<b>Requested On:</b> #DateFormat(s_date, "MM/DD/YY")#<br />
<b>Assignee(s):</b> 

<cfif '#Get_projects_all.w_fname#' NEQ ''>#w_fname#
<cfelseif '#Get_projects_all.w_fname#' EQ '' AND '#Get_projects_all.owner2#' NEQ ''>#Get_projects_all.owner2#
<cfelseif '#Get_projects_all.owner2#' EQ '' AND '#Get_projects_all.owner3#' NEQ ''>#Get_projects_all.owner3#
<cfelseif '#Get_projects_all.owner3#' EQ '' AND '#Get_projects_all.owner4#' NEQ ''>#Get_projects_all.owner4#
</cfif>

<br />

<cfquery name="Get_notes_full" datasource="#request.dsn#">
SELECT * 
FROM T_Notes
WHERE Ticket_ID = '#Get_projects_all.ProjectID#'
ORDER BY n_date DESC
</cfquery>

<cfif '#Get_notes_full.pnotes#' EQ ""><span style="font-size:10px; color:##999;"><b>Notes:</b> There are no notes for this ticket at this time.</span>
<cfelse><b>Notes:</b> #Get_notes_full.pnotes#</cfif> 

</td></tr>
</cfoutput>
</cfif>
</table>
<!--end  tickets table -->

<cfinclude template="footer.cfm">

</center>
</body>
</html>
