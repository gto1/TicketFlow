<cfinclude template="header.cfm">
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Thank You</td></tr>
<tr height="20px" style="color:#000000; font-size: 12px;">
<!--- IS URL.LOGOUT DEFINED? --->
<td>
<cfif IsDefined ("url.logout")>
<!--- DELETE ALL SESSION VARIABLES --->
<cfset structclear(session)>
		<!--- TEST IF LOGOUT TRUE --->
<cfif IsDefined("session.userFname")>
The session is still alive, please click here to <a href="logout.cfm?Logout=Yes" style="font-size:12px;">end your session</a>.
<cfelse>
Your session has ended. Goodbye.
</cfif></cfif></td></tr>

<tr height="20px"><td></td></tr>
<cfinclude template="ap_footer.cfm">



