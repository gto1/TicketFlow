<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Thank You</td></tr>
<tr height="20px" style="color:#000000; font-size: 12px;">
<td>Your work ticket has been successfully submitted.


<table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Project Ticket Details:</b></span></td></tr>
<tr><td width="250px"><strong>Requested:</strong></td><td width="450px">#FORM.userFname# #FORM.userLname#</td></tr>
<tr><td><strong>Team:</strong></td><td>#FORM.Team_Name#</td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Last_Ticket_ID.ProjectID#</td></tr>
<tr><td><b>Submitted:</b></td><td>#TimeFormat(FORM.s_date, 'hh:mm')# on #DateFormat(FORM.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#FORM.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#FORM.pscope#</td></tr>
<tr><td><strong>Title:</strong></td><td>#FORM.ptitle#</td></tr>
<tr><td><strong>Description:</strong></td><td>#FORM.pdesc#</td></tr>
<cfif FORM.pnotes NEQ ""><tr><td><strong>Notes:</strong></td><td>#FORM.pnotes#</td></tr></cfif>
<tr><td><strong>Due Date:</strong></td><td>#FORM.pdue#</td></tr></table>



<br /><br />
<span style="color: #999999; font-style:italic;">What would you like to do now?..</span><br />
<br />
<a href="insert.cfm">Submit another ticket</a> | <a href="https://intranet.osa.psu.edu/intranet/index.html" name="OSA Home">OSA Intranet Home</a></td></tr>
<tr height="20px"><td></td></tr>

<tr><td align="left">

</td></tr>
<cfinclude template="ap_footer.cfm">



