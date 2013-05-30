<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Assigned Tickets</td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>This is a table showing tickets that have been assigned to a team member.
<cfif '#Get_projects_assigned.recordcount#' EQ 0><br><br><p style="font-size:12px"><span style="font-weight: bold">Note</span>: Currently, there are no records in this table.</p>
<cfelse></td></tr>
</table>

<table width="950px" border="1px" bordercolor="#CCCCCC" cellpadding="5px" cellspacing="0px">
<tr height="20px" bgcolor="#333333" style="color:#FFFFFF; font-weight: bold; font-size: 12px;">
<td width="25px" align="left" valign="top">No.</td>
<td width="185px" align="left" valign="top">Project Title</td>
<td width="420px" align="left" valign="top">Description</td>
<td width="110px" align="left" valign="top">Requested By</td>
<td width="70px" align="left" valign="top">Want Date</td>
<td width="70px" align="left" valign="top">Submitted</td>
<td width="50px" align="left" valign="top">Assigned</td></tr>

<cfoutput query="Get_Projects_assigned">
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))# style="font-size: 10px;">
<td align="left" valign="top">#ProjectID#</td>
<td align="left" valign="top">#Left(ptitle, Find('', ptitle, 30))#</td>
<td align="left" valign="top">#Left(pdesc, Find('', pdesc, 65))# [<a href="detail.cfm?ID=#ProjectID#">Detail</a>]</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top">#w_fname#</td></tr>
</cfoutput>
</cfif>
</table>
<!--end  tickets table -->

<cfinclude template="footer.cfm">

</center>
</body>
</html>
