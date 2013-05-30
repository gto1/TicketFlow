<cfinclude template="header_public.cfm">

<cfquery name="Get_LastID" datasource="#request.dsn#" maxrows="1">
SELECT ProjectID
FROM T_Project_Manager
ORDER BY ProjectID DESC
</cfquery>

<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: normal; font-size: 12px;">
<td align="left"><b>Thank You!..</b> <i>Your work ticket has been successfully submitted...</i> <br /><br />
For your records a summary report has been emailed to you for work ticket no. <cfoutput>#Get_LastID.ProjectID#</cfoutput>. The Communication and Student Services team has been notified of your request. We will be in contact with you as soon as is necessary.<br /><br />
Thank you,<br />
The Communication and Student Services Team<br />
<br /><br />
<span style="color: #999999; font-style:italic;">What would you like to do now?..</span><br />
<br />
<a href="insert_public.cfm">Submit another ticket</a> | <a href="https://intranet.osa.psu.edu/intranet/index.html" name="OSA Home">OSA Intranet Home</a></td>
</tr>
<tr height="20px"><td></td></tr>


<cfinclude template="ap_footer.cfm">



