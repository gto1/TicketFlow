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





function validate_required(field,alerttxt)
{
with (field)
  {
  if (value==null||value=="")
    {
    alert(alerttxt);return false;
    }
  else
    {
    return true;
    }
  }
}

function validate_form(thisform)
{
with (thisform)
  {
  if (validate_required(userFname,"You must enter your first name.")==false)
  {userFname.focus();return false;}
  }
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
<b>Project Management Application 1.1</b> &nbsp;  
<cfoutput>#DateFormat(Now(), "MMMM DD, YYYY")#</cfoutput></span> &nbsp; 




<!--If user is not Admin, see this only this part of the nav menu, Admin sees it also  -->
<span style="color:#666666; font-size: 10px;">
<a href="insert_public.cfm" name="Create New Ticket">Create New Ticket</a> | 
<!--<a href="doc.cfm" name="Help">Help</a> | -->
<!--<a href="index.cfm" name="Home">PMA 1.1</a> |  -->
<a href="https://intranet.osa.psu.edu/intranet/index.html" name="OSA Home">OSA Intranet Home</a></span></span></td>
</tr>
<tr><td><hr width="100%" align="left" size="1px" color="#999999"></td></tr>