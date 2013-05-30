<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Closed Tickets</td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>
This is a table showing tickets for which the work has been accepted as complete and satisactory and has been signed of on by person who requested the work.

<cfif '#Get_projects_closed.recordcount#' EQ 0><br><br><p style="font-size:12px"><span style="font-weight: bold">Note</span>: Currently, there are no records in this table.</p>
<cfelse></td></tr>
</table>

<table width="700px" border="1px" bordercolor="#CCCCCC" cellpadding="5px" cellspacing="0px">
<tr height="20px" bgcolor="#333333" style="color:#FFFFFF; font-weight: bold; font-size: 12px;">
<td width="25px" align="left" valign="top">No.</td>
<td width="200px" align="left" valign="top">Project Title</td>
<td width="355px" align="left" valign="top">Description</td>
<td width="110px" align="left" valign="top">Submitted By</td>
<td width="70px" align="left" valign="top">Request</td>
<td width="70px" align="left" valign="top">Submitted</td>
<td width="50px" align="left" valign="top">Owner</td></tr>

<cfoutput query="Get_projects_closed">
<tr height="20px" bgcolor=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))# style="font-size: 10px;">
<td align="left" valign="top">#Projects_ID#</td>
<td align="left" valign="top">#ptitle#</td>
<td align="left" valign="top">#pdesc#</td>
<td align="left" valign="top">#userFname# #userLname#</td>
<td align="left" valign="top">#pdue#</td>
<td align="left" valign="top">#DateFormat(s_date, "MM/DD/YY")#</td>
<td align="left" valign="top">#w_fname#</td></tr>
</cfoutput>
</cfif>
</table>
<!--end tickets table -->

<div class="footer2">Pennsylvania State University - Office of Student Aid - Communication & Student Services
Project Management System 1.0 &copy; 2009<br />
For information, issues, or suggestions on this application contact <a href="mailto:gto1@psu.edu">Greg O'Toole</a> (gto1),  867-0621.</div>

</center>
</body>
</html>

