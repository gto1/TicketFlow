<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>An Error Has Occured...</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
Sorry, <cfoutput>#session.username#</cfoutput>, an error has occured. Greg has been notified and will follow up with you if needed. Please close your browser and try again later. Thanks for your patience.
  
<cflog file="myapperrorlog" text="#error.message# - #error.diagnostics#">
  
<cfsavecontent variable="errortext">
<cfoutput>
An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#<br />
User who received the error: #session.username#<br /><br />
  

Browser: #Error.Browser#<br />
Remote Address: #Error.RemoteAddress#<br /><br /><br />
  
<cfdump var="#error#" label="Error">
<cfdump var="#form#" label="Form">
<cfdump var="#url#" label="URL">
  
</cfoutput>
</cfsavecontent>
  
  
<cfmail to="gto1@studentaid.psu.edu" from="gto1@psu.edu" subject="Project Tracker Error" type="html">
      #errortext#
</cfmail>

</body>
</html>
