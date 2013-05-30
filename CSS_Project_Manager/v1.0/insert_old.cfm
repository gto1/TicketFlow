<cfinclude template="header.cfm">


<!--- IF FORM.INSERT IS DEFINED --->
<cfif IsDefined ("FORM.Insert")>

<!--- query that drops graphagromaniacs admin info into db --->
<cfquery name="TestInsert" datasource="OSA">
INSERT INTO T_proj_man (sub_fname, sub_lname, ptitle, pdesc, w_fname, w_lname, due, status)
	VALUES
	(
	<cfif FORM.sub_fname NEQ "">'#Trim(FORM.sub_fname)#'<cfelse>NULL</cfif>,
	<cfif FORM.sub_lname NEQ "">'#Trim(FORM.sub_lname)#'<cfelse>NULL</cfif>,
    <cfif FORM.ptitle NEQ "">'#Trim(FORM.ptitle)#'<cfelse>NULL</cfif>,
    <cfif FORM.pdesc NEQ "">'#Trim(FORM.pdesc)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_fname NEQ "">'#Trim(FORM.w_fname)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_lname NEQ "">'#Trim(FORM.w_lname)#'<cfelse>NULL</cfif>,
    <cfif FORM.due NEQ "">'#Trim(FORM.due)#'<cfelse>NULL</cfif>,
    <cfif FORM.status NEQ "">'#Trim(FORM.status)#'<cfelse>NULL</cfif>
	)
</cfquery> 

Data entered successfully!
<cfabort>
</cfif>
<!--- ===========/OF ACTION SECTION================ --->

<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Work Ticket Request Form - Communication / Student Services</td></tr>
<tr><td style="font-size:12px;">Please fill out this form in order to submit a work ticket to the Office of Student Aid Communication & Student Services Team. You will receive an email confirmation and summary of your work ticket. Our team will be notified and we will be in contact with you as soon as possible. Thank you.</td></tr></table>

<cfform  name="test_new_insert"  method="post"  action="#cgi.SCRIPT_NAME#">
<center><table width="900px" border="0">
<tr>
<td align="left" valign="top" width="130px" height="35px" style="font-size:12px;">	  
First Name</td>
<td width="450px" align="left" valign="top">
<input type="text" name="sub_fname" size="12" maxlength="255" value="<cfoutput>#UserFname#</cfoutput>"></td>
<td rowspan="6" width="*"></td></tr>

<tr><td align="left" valign="top" height="35px" style="font-size:12px;">
Last Name</td><td align="left" valign="top">
<input type="text" name="sub_lname" size="12" maxlength="255" value="<cfoutput>#UserLname#</cfoutput>"> </td></tr>

<tr><td align="left" valign="top" height="35px" style="font-size:12px;">
Project Type</td><td align="left" valign="top" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;">
<input type="radio" name="ptype" value="Web">Web &nbsp; 
<input type="radio" name="ptype" value="Intranet">Intranet &nbsp; 
<input type="radio" name="ptype" value="Print">Print &nbsp; 
<input type="radio" name="ptype" value="Other">Other &nbsp; </td></tr>

<tr><td align="left" valign="top" height="35px" style="font-size:12px;">
Project Scope</td><td align="left" valign="top" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;">
<input type="radio" name="pscope" value="Minor">Minor Edits / Updates &nbsp; 
<input type="radio" name="pscope" value="Major">Major Edits / Updates  &nbsp; 
<input type="radio" name="pscope" value="New">New &nbsp; 
<input type="radio" name="pscope" value="Other">Other &nbsp; </td></tr>

<tr><td align="left" valign="top" height="35px" style="font-size:12px;">
Project Title</td><td align="left" valign="top">
<input type="text" name="ptitle" size="40" maxlength="255"></td></tr>

<tr><td align="left" valign="top" height="35px" style="font-size:12px;">
Description</td><td align="left" valign="top">
<textarea name="pdesc" style="width:250px"></textarea></td></tr> 

<tr><td align="left" valign="top" height="35px" style="font-size:12px;">
Proposed Due Date</td><td align="left" valign="top">
<input type="text" name="due" size="12" maxlength="255" value="MM/DD/YY"></td></tr> 

<tr><td height="35px"></td><td align="left" valign="top">
<input type="hidden" name="w_fname" value="None">
<input type="hidden" name="w_lname" value="None">
<input type="hidden" name="status" value="Assign">
<input type="submit" name="Insert" value="Submit">
<INPUT TYPE="hidden" NAME="s_date" VALUE="DateFormat(Now(), "DD MMMM YYYY")">			      
</td></tr></table></center>
</cfform>

</body>
</html>
