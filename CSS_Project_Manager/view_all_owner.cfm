<cfinclude template="header.cfm">

<cfquery name="Get_projects_owner" datasource="#request.dsn#">
SELECT * 
FROM T_Project_Manager
WHERE w_fname = '#URL.Owner#' OR owner2 = '#URL.Owner#' OR owner3 = '#URL.Owner#' OR owner4 = '#URL.Owner#'
ORDER BY Status, ProjectID DESC
</cfquery>


<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left"><span class="status_head"><cfoutput>#URL.Owner#</cfoutput> - All Tickets</span></td></tr>
<!--- <tr height="20px" style="color:#000000; font-size: 10px;">
<td>You may view all of the tickets by: 

<a href="view_all_owner.cfm?Owner=Brooke">Brooke</a> | 
<a href="view_all_owner.cfm?Owner=Giovanna">Giovanna</a> | 
<a href="view_all_owner.cfm?Owner=Greg">Greg</a> | 
<a href="view_all_owner.cfm?Owner=Tammy">Tammy</a> | 
<a href="view_all_owner.cfm?Owner=Tina">Tina</a> |
<a href="view_all_owner.cfm?Owner=Kyle">Kyle</a>--->


<cfif '#Get_projects_owner.recordcount#' EQ 0>
<tr height="20px" style="color:#000000; font-size: 10px;"><td>
<p>There are currently no tickets assigned to <cfoutput>#URL.Owner#</cfoutput>.</p>
</td></tr></table><cfelse> 
</table>

<table width="950px" border="1px" bordercolor="#999999" cellpadding="5px" cellspacing="0px">
<tr height="20px" bgcolor="#333333" style="color:#FFFFFF; font-weight: bold; font-size: 12px;">
<td width="23px" align="left" valign="top">No.</td>
<td width="165px" align="left" valign="top">Project Title</td>
<td width="*" align="left" valign="top">Description</td>
<td width="110px" align="left" valign="top">Requested By</td>
<td width="80px" align="left" valign="top">Deadline</td>
<td width="70px" align="left" valign="top">Submitted</td>
<td width="55px" align="left" valign="top">Assignee(s)</td>
<td width="50px" align="left" valign="top">Status</td></tr>

<cfoutput query="Get_projects_owner">

<cfquery name="Get_Owner_Statuses" datasource="#request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = '#Get_projects_owner.status#'
</cfquery>


<cfif #Get_Owner_Statuses.Status# IS 'Closed'>
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('bbbbbb'), DE ('bbbbbb'))# style="font-size: 10px;">
<td align="left" valign="top">#ProjectID#</td>
<td align="left" valign="top">#Left(ptitle, Find('', ptitle, 22))#</td>
<td align="left" valign="top">#Left(pdesc, Find('', pdesc, 40))# [<a href="detail.cfm?ID=#ProjectID#">Detail</a>]</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top">
<cfif '#Get_projects_owner.w_fname#' NEQ ''>#w_fname#
<cfelseif '#Get_projects_owner.w_fname#' EQ '' AND '#Get_projects_owner.owner2#' NEQ ''>#Get_projects_owner.owner2#
<cfelseif '#Get_projects_owner.owner2#' EQ '' AND '#Get_projects_owner.owner3#' NEQ ''>#Get_projects_owner.owner3#
<cfelseif '#Get_projects_owner.owner3#' EQ '' AND '#Get_projects_owner.owner4#' NEQ ''>#Get_projects_owner.owner4#
</cfif>

<cfif '#Get_projects_owner.owner2#' NEQ '' OR '#Get_projects_owner.owner3#' NEQ '' OR '#Get_projects_owner.owner4#' NEQ ''>
<a href="detail.cfm?ID=#ProjectID#">+</a></cfif></td>
<td align="left" valign="top">#Get_Owner_Statuses.Status#</td></tr>


<cfelseif #Get_Owner_Statuses.Status# IS 'Complete'>
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('ff9933'), DE ('ff9933'))# style="font-size: 10px;">
<td align="left" valign="top">#ProjectID#</td>
<td align="left" valign="top">#Left(ptitle, Find('', ptitle, 22))#</td>
<td align="left" valign="top">#Left(pdesc, Find('', pdesc, 40))# [<a href="detail.cfm?ID=#ProjectID#">Detail</a>]</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top">
<cfif '#Get_projects_owner.w_fname#' NEQ ''>#w_fname#
<cfelseif '#Get_projects_owner.w_fname#' EQ '' AND '#Get_projects_owner.owner2#' NEQ ''>#Get_projects_owner.owner2#
<cfelseif '#Get_projects_owner.owner2#' EQ '' AND '#Get_projects_owner.owner3#' NEQ ''>#Get_projects_owner.owner3#
<cfelseif '#Get_projects_owner.owner3#' EQ '' AND '#Get_projects_owner.owner4#' NEQ ''>#Get_projects_owner.owner4#
</cfif>

<cfif '#Get_projects_owner.owner2#' NEQ '' OR '#Get_projects_owner.owner3#' NEQ '' OR '#Get_projects_owner.owner4#' NEQ ''>
<a href="detail.cfm?ID=#ProjectID#">+</a></cfif></td>
<td align="left" valign="top">#Get_Owner_Statuses.Status#</td></tr>
<cfelse>

<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))# style="font-size: 10px;">
<td align="left" valign="top">#ProjectID#</td>
<td align="left" valign="top">#Left(ptitle, Find('', ptitle, 22))#</td>
<td align="left" valign="top">#Left(pdesc, Find('', pdesc, 40))# [<a href="detail.cfm?ID=#ProjectID#">Detail</a>]</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top">
<cfif '#Get_projects_owner.w_fname#' NEQ ''>#w_fname#
<cfelseif '#Get_projects_owner.w_fname#' EQ '' AND '#Get_projects_owner.owner2#' NEQ ''>#Get_projects_owner.owner2#
<cfelseif '#Get_projects_owner.owner2#' EQ '' AND '#Get_projects_owner.owner3#' NEQ ''>#Get_projects_owner.owner3#
<cfelseif '#Get_projects_owner.owner3#' EQ '' AND '#Get_projects_owner.owner4#' NEQ ''>#Get_projects_owner.owner4#
</cfif>



<cfif '#Get_projects_owner.owner2#' NEQ '' OR '#Get_projects_owner.owner3#' NEQ '' OR '#Get_projects_owner.owner4#' NEQ ''>
<a href="detail.cfm?ID=#ProjectID#">+</a></cfif></td>
<td align="left" valign="top">#Get_Owner_Statuses.Status#</td></tr>
</cfif>

</cfoutput>














</cfif>
</table>
<!--end  tickets table -->

<cfinclude template="footer.cfm">

</center>
</body>
</html>
