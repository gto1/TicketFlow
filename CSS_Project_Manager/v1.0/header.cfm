<cfinclude template="sql.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>PSU OSA Project Tracker</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="style.css" rel="stylesheet" type="text/css">

<script type="text/JavaScript">
<!--

function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
//-->
</script>

</head>

<body bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size: 10px;">
<center>
<!---start new tickets table --->
<table width="700px" border="0">
<tr height="30px">
<td><span style="color:#999999; font-size: 14px;">Pennsylvania State University - Office of Student Aid - Communication and Student Services<br>
<b>Project Management System 1.0</b> &nbsp;  
<cfoutput>#DateFormat(Now(), "MMMM DD, YYYY")#</cfoutput></span> &nbsp; 


<!--Check to see if user is Admin --> 
<!--- <cfif URL.User EQ 1>  --->

<!---If user is Admin, see this part of the nav menu --->
<span style="color:#666666; font-size: 10px;"><br />
<hr width="100%" align="left" size="1px" color="#999999">
Tickets: 
<cfoutput query="Get_projects_new" maxrows="1">
<cfif '#Get_projects_new.recordcount#' NEQ 0><a href="view_new.cfm" style="color:##FF0000">New (#recordcount#)</a>
<cfelse><a href="view_new.cfm">New (#recordcount#)</a></cfif>
</cfoutput> | 

<a href="view_assigned.cfm">Assigned <cfif '#Get_projects_assigned.recordcount#' NEQ 0><cfoutput query="Get_projects_assigned" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a> | 

<a href="view_dev.cfm">Development <cfif '#Get_projects_development.recordcount#' NEQ 0><cfoutput query="Get_projects_development" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>  | 

<a href="view_complete.cfm">Complete <cfif '#Get_projects_complete.recordcount#' NEQ 0><cfoutput query="Get_projects_complete" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>  | 

<a href="view_closed.cfm">Closed <cfif '#Get_projects_closed.recordcount#' NEQ 0><cfoutput query="Get_projects_closed" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>   |
<!--<a href="insert.cfm?User=1" name="Admin">Admin</a> | -->

<!--- </cfif> --->

<!--If user is not Admin, see this only this part of the nav menu, Admin sees it also  -->
<span style="color:#666666; font-size: 10px;">
<a href="insert.cfm" name="Create New Ticket">Create New Ticket</a> | 
<a href="doc.cfm" name="Help">Help</a> |
<a href="insert.cfm" name="Home">Home</a></span></span></td>
</tr>
<tr><td><hr width="100%" align="left" size="1px" color="#999999"></td></tr>