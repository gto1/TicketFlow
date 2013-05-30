<cfinclude template="header.cfm">


<!--- IF FORM.INSERT IS DEFINED --->
<cfif IsDefined ("FORM.Insert")>

<!--- query that drops graphagromaniacs admin info into db --->
<cfquery name="Insert" datasource="OSA">
INSERT INTO T_proj_man (sub_fname, sub_lname, ptitle, pdesc, ptype, pscope, w_fname, w_lname, due, status)
	VALUES
	(
	#UserFname#,
	#UserLname#,
    <cfif FORM.ptitle NEQ "">'#Trim(FORM.ptitle)#'<cfelse>NULL</cfif>,
    <cfif FORM.pdesc NEQ "">'#Trim(FORM.pdesc)#'<cfelse>NULL</cfif>,
    <cfif FORM.ptype NEQ "">'#Trim(FORM.ptype)#'<cfelse>NULL</cfif>,
    <cfif FORM.pscope NEQ "">'#Trim(FORM.pscope)#'<cfelse>NULL</cfif>,
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

<cfform  name="new_insert"  method="post"  action="#cgi.SCRIPT_NAME#">
<center><table width="900px" border="0">
<tr height="15px"><td></td></tr>


<fieldset border="1px" bordercolor="#006633" style="background:#ffffff; text-align:left; padding:3px; font-family:Arial, Helvetica, sans-serif; font-size:11px; line-height:15px; width:900px">
<legend class="style1">Web Sites</legend>

<tr><td align="left" valign="top" style="font-size:12px;" height="25px">	  
<b><cfoutput>#UserFname# #UserLname#</cfoutput></b></td></tr>

<tr><td align="left" valign="top" style="font-size:12px;" height="35px">
1. What type of project are you requesting?  &nbsp; 
<cfinput type="radio" name="ptype" value="Web">Web &nbsp; 
<cfinput type="radio" name="ptype" value="Intranet">Intranet &nbsp; 
<cfinput type="radio" name="ptype" value="Print">Print &nbsp; 
<cfinput type="radio" name="ptype" value="Other">Other &nbsp; 
</td></tr>

<tr><td align="left" valign="top" style="font-size:12px;" height="35px">
2. What is the scope of this project?  &nbsp; 
<cfinput type="radio" name="pscope" value="Minor">Minor Edits / Updates &nbsp; 
<cfinput type="radio" name="pscope" value="Major">Major Edits / Updates  &nbsp; 
<cfinput type="radio" name="pscope" value="New">New &nbsp; 
<cfinput type="radio" name="pscope" value="Other">Other &nbsp; 
</td></tr>

<tr><td align="left" valign="top" style="font-size:12px;" height="35px">
3. Please give your project a title: &nbsp;  
<cfinput type="text" name="ptitle" size="30" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999;">
</td></tr>

<tr><td align="left" valign="top" style="font-size:12px;" height="75px">
4. If necessary, please supply a brief project description. <br>
<textarea name="pdesc" style="width:300px;border-style:dashed; border-width:thin; border-color:#999999;"></textarea>
</td></tr> 

<tr><td align="left" valign="top" style="font-size:12px;" height="35px">
5. When would you like this project to be completed? &nbsp; 
<cfinput type="text" name="due" size="12" maxlength="255" value="MM/DD/YY" style="border-style:dashed; border-width:thin; border-color:##999999;"></td></tr> 

</fieldset>


<tr><td align="left" valign="top" height="35px">
<cfinput type="hidden" name="w_fname" value="#UserFName#">
<cfinput type="hidden" name="w_lname" value="#UserLName#">
<cfinput type="hidden" name="status" value="Assign">
<cfinput type="submit" name="Insert" value="Submit">
<cfinput type="hidden" name="s_date" value="DateFormat(Now(), 'DD MMMM YYYY')">			      
</td></tr></table></center>
</cfform>

</body>
</html>
