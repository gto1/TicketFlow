<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">

<cfquery name="Get_Statuses" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = '#URL.Status#'
</cfquery>

<span class="status_head"><cfoutput>#Get_Statuses.Status#</cfoutput></span> </td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>This is a table showing all current tickets that are of the status <cfoutput>#Get_Statuses.Status#</cfoutput>.
<cfif '#Get_projects_exp.recordcount#' EQ 0><br><br><span class="red_text">There are no records in this table at this time.</span></p>
<cfelse></td></tr>
</table>

<table width="950px" border="1px" bordercolor="#CCCCCC" cellpadding="5px" cellspacing="0px">
<tr height="20px" bgcolor="#333333" style="color:#FFFFFF; font-weight: bold; font-size: 12px;">
<td width="25px" align="left" valign="top">No.</td>
<td width="160px" align="left" valign="top">Project Title</td>
<td width="*" align="left" valign="top">Description</td>
<td width="110px" align="left" valign="top">Requested By</td>
<td width="80px" align="left" valign="top">Deadline</td>
<td width="70px" align="left" valign="top">Submitted</td>
<td width="55px" align="left" valign="top">Assignee(s)</td></tr>

<cfoutput query="Get_projects_exp">
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))# style="font-size: 10px;">
<td align="left" valign="top">#ProjectID#</td>
<td align="left" valign="top">#Left(ptitle, Find('', ptitle, 25))#</td>
<td align="left" valign="top">#Left(pdesc, Find('', pdesc, 50))# [<a href="detail.cfm?ID=#ProjectID#">Detail</a>]</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top"><cfif '#URL.Status#' EQ 1>
<a href="edit_status.cfm?ID=#ProjectID#" title="Assign the ticket" name="Assign the ticket">Assign</a>
<cfelse>#w_fname# 

<cfif '#Get_projects_exp.owner2#' NEQ ''><a href="detail.cfm?ID=#ProjectID#">+</a></cfif>

</cfif></td></tr>
</cfoutput>


</cfif>
</table>
<!--end new tickets table -->

<cfinclude template="footer.cfm">

</center>
</body>
</html>
