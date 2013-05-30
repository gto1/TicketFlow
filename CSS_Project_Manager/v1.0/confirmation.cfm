<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Thank You</td></tr>
<tr height="20px" style="color:#000000; font-size: 12px;">
<td>Your work ticket has been successfully submitted. Your summary report has been emailed to you. The Communication & Student Services team has been notified of your request. We will be in contact with you as soon as we can. Thank you, please click here to <a href="logout.cfm?Logout=Yes" style="font-size:12px;">end your session</a>.</td>
</tr>
<tr height="20px"><td></td></tr>

<tr><td align="left">
<fieldset border="1px" bordercolor="#006633" style="background:#ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; line-height:15px; width:700px; font-size:12px;">
<legend> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #3399FF; font-weight: bold">PROJECT SUMMARY</span> </legend>
<cfoutput><br>
<strong>Name:</strong> #session.userFname# #session.userLname#<br><br>
<strong>Type:</strong> #session.ptype#<br><br>
<strong>Scope:</strong> #session.pscope#<br><br>
<strong>Title:</strong> #session.ptitle#<br><br>
<strong>Description:</strong> #session.pdesc#<br><br>
<strong>Requested Due Date:</strong> #session.pdue#<br><br><br>
Please click here to <a href="logout.cfm?Logout=Yes" style="font-size:12;">end your session</a>.<br>
</cfoutput></fieldset>
</td></tr>
<cfinclude template="ap_footer.cfm">

<!--- IS URL.LOGOUT DEFINED? --->
<cfif IsDefined ("url.logout")>
<!--- DELETE ALL SESSION VARIABLES --->
<cfset structclear(session)>
		<!--- TEST IF LOGOUT TRUE --->
<cfif IsDefined("session.userFname")>
The session is still alive.
<cfelse>
Signed out!
</cfif></cfif> 


