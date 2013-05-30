<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Thank You</td></tr>
<tr height="20px" style="color:#000000; font-size: 12px;">
<td>Your work ticket has been successfully submitted.</td></tr>
<tr height="20px"><td></td></tr>

<tr><td align="left" style="color:#666666; font-size: 10px;">
<fieldset border="1px" bordercolor="#006633" style="background:#ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; line-height:15px; width:700px">
<legend> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #3399FF; font-weight: bold">PROJECT SUMMARY</span> </legend>
<!--- IS URL.LOGOUT DEFINED? --->
<cfif IsDefined ("url.logout")>
<!--- DELETE ALL SESSION VARIABLES --->
<cfset structclear(session)>
		<!--- TEST IF LOGOUT TRUE --->
<cfif IsDefined("session.userFname")>
The session is still alive.
<cfelse>
Your session has ended. Goodbye.
</cfif></cfif></fieldset>
</td></tr>
<cfinclude template="ap_footer.cfm">