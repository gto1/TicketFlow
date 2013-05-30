<cfinclude template="sql.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>PSU OSA Project Tracker</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="style.css" rel="stylesheet" type="text/css">



<!-- validate First name -->
<script type="text/javascript">
// validates that the field value string has one or more characters in it
function isNotEmpty(elem) {
  var str = elem.value;
    var re = /.+/;
    if(!str.match(re)) {
        alert("Please fill in each of the required fields.");
        setTimeout("focusElement('" + elem.form.name + "', '" + elem.name + "')", 0);
        return false;
    } else {
        return true;
    }
}



// batch validation router
function validateForm(form) {
    if (isNotEmpty(form.userFname)) {
        if (isNotEmpty(form.userLname)) {
            if (isNotEmpty(form.ptitle)) {
                if (isNotEmpty(form.pdesc)) {
					if (isNotEmpty(form.pdue)) {


                            return true;

                	}
                }
            }
        }
    }
    return false;
}
</script>












<script type="text/JavaScript">
<!--

function clearText(field){

    if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;

}
//-->
</script>

<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
var agree=confirm("You are about to change the status of this ticket. Is this what you want to do?");
if (agree)
return true ;
else
return false ;
}
// -->
</script>


<style type="text/css">
<!--
.beta {
	font-size: 12px;
	color:#9CF;
	font-weight: bold;
}
-->
</style>
</head>

<body bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size: 10px;">
<center>
<!---start new tickets table --->
<table width="950px" border="0">
<tr height="30px">
<td><div class="header" style="color:#999999; font-size: 14px;">The Pennsylvania State University - Office of Student Aid - Communication and Student Services<br>
<b>Project Tracker 1.2 <span class="beta">Beta</span></b> &nbsp;  
<span style="font-size: 12px;"><cfoutput>#TimeFormat(Now(), "h:MM tt")# on #DateFormat(Now(), "dddd, MMMM DD, YYYY")#
 &nbsp; Welcome, <b>#session.username#</b></cfoutput></span></span> &nbsp; 


<!--Check to see if user is Admin --> 
<!--- <cfif URL.User EQ 1>  --->

<!---If user is Admin, see this part of the nav menu --->
<span style="color:#666666; font-size: 10px;"><br />
<hr width="100%" align="left" size="1px" color="#999999">

<a href="view_exp.cfm?Status=1" style="color:##FF0000"><cfif '#Get_projects_new.recordcount#' NEQ 0><cfoutput query="Get_projects_new" maxrows="1"><font color="##FF0000">New (#recordcount#)</font></cfoutput><cfelse>New (0)</cfif></a> | 

<a href="view_exp.cfm?Status=2">Assigned <cfif '#Get_projects_assigned.recordcount#' NEQ 0><cfoutput query="Get_projects_assigned" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a> | 

<a href="view_exp.cfm?Status=3">Design <cfif '#Get_projects_design.recordcount#' NEQ 0><cfoutput query="Get_projects_design" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a> | 

<a href="view_exp.cfm?Status=4">Development <cfif '#Get_projects_development.recordcount#' NEQ 0><cfoutput query="Get_projects_development" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>  | 

<a href="view_exp.cfm?Status=5">Proof / Edit <cfif '#Get_projects_proof.recordcount#' NEQ 0><cfoutput query="Get_projects_proof" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a> | 

<a href="view_exp.cfm?Status=7">Complete <cfif '#Get_projects_complete.recordcount#' NEQ 0><cfoutput query="Get_projects_complete" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>  | 

<a href="view_exp.cfm?Status=6">Printer <cfif '#Get_projects_printer.recordcount#' NEQ 0><cfoutput query="Get_projects_printer" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a> | 

<a href="view_exp.cfm?Status=8">Closed <cfif '#Get_projects_closed.recordcount#' NEQ 0><cfoutput query="Get_projects_closed" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>   |

<a href="view_exp.cfm?Status=9">Deferred <cfif '#Get_projects_def.recordcount#' NEQ 0><cfoutput query="Get_projects_def" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>   |

<a href="view_all.cfm">All <cfif '#Get_projects_all.recordcount#' NEQ 0><cfoutput query="Get_projects_all" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>   |

<a href="view_all_full.cfm">Full All <cfif '#Get_projects_all.recordcount#' NEQ 0><cfoutput query="Get_projects_all" maxrows="1">(#recordcount#)</cfoutput><cfelse>(0)</cfif></a>  | 
<!--- </cfif> --->

<!--If user is not Admin, see only this part of the nav menu, Admin sees it also  -->
<span style="color:#666666; font-size: 10px;">
<a href="insert.cfm" name="Create New Ticket">Create New Ticket</a> | 
<a href="home.cfm" name="Home">Help</a></span></span></td>
</tr>
<tr><td><hr width="100%" align="left" size="1px" color="#999999">
<span style="color:#666666; font-size: 10px;">
View tickets by owner: 
<a href="view_all_owner.cfm?Owner=Brooke">Brooke</a> | 
<a href="view_all_owner.cfm?Owner=Greg">Greg</a> | 
<a href="view_all_owner.cfm?Owner=Kyle">Kyle</a> | 
<a href="view_all_owner.cfm?Owner=Tammy">Tammy</a> | 
<a href="view_all_owner.cfm?Owner=Tina">Tina</a>

<hr width="100%" align="left" size="1px" color="#999999"></td></tr>