<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">All Tickets</td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>This is a table showing all of the tickets currently logged in the Project Tracker system.

<cfif '#Get_projects_all.recordcount#' EQ 0><br><br>
<p style="font-size:12px"><span style="font-weight: bold">Note</span>: Currently, there are no records in this table.</p>
<cfelse></td></tr>
</table>

<table width="950px" border="1px" bordercolor="#CCCCCC" cellpadding="5px" cellspacing="0px">
<tr height="20px" bgcolor="#333333" style="color:#FFFFFF; font-weight: bold; font-size: 12px;">
<td width="25px" align="left" valign="top">No.</td>
<td width="160px" align="left" valign="top">Project Title</td>
<td width="*" align="left" valign="top">Description</td>
<td width="105px" align="left" valign="top">Requested By</td>
<td width="85px" align="left" valign="top">Deadline</td>
<td width="70px" align="left" valign="top">Submitted</td>
<td width="50px" align="left" valign="top">Assignee(s)</td>
<td width="50px" align="left" valign="top">Status</td></tr>

<cfoutput query="Get_projects_all">
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))# style="font-size: 10px;">
<td align="left" valign="top">#ProjectID#</td>
<td align="left" valign="top">#Left(ptitle, Find('', ptitle, 27))#</td>
<td align="left" valign="top">#Left(pdesc, Find('', pdesc, 45))# [<a href="detail.cfm?ID=#ProjectID#">Detail</a>]</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top">

<cfif '#Get_projects_all.w_fname#' NEQ ''>#w_fname#
<cfelseif '#Get_projects_all.w_fname#' EQ '' AND '#Get_projects_all.owner2#' NEQ ''>#Get_projects_all.owner2#
<cfelseif '#Get_projects_all.owner2#' EQ '' AND '#Get_projects_all.owner3#' NEQ ''>#Get_projects_all.owner3#
<cfelseif '#Get_projects_all.owner3#' EQ '' AND '#Get_projects_all.owner4#' NEQ ''>#Get_projects_all.owner4#
</cfif>



</td>
<td align="left" valign="top">
<cfquery name="Get_Statuses" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = #Get_projects_all.status#
</cfquery>
#Get_Statuses.Status#
</td></tr>
</cfoutput>
</cfif>
</table>
<!--end  tickets table -->

<cfinclude template="footer.cfm">

</center>
</body>
</html>
