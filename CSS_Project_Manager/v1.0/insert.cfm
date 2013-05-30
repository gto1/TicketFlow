<cfinclude template="header.cfm">

<!--- IF FORM.INSERT IS DEFINED --->
<cfif IsDefined ("FORM.Insert")>

<!--- query that drops graphagromaniacs admin info into db --->
<cfquery name="DropInNewProject" datasource="#request.dsn#">
INSERT INTO T_Project_Manager (userFname, userLname, userEmail, ptype, pscope, ptitle, pdesc, pdue, w_fname, w_lname, w_email, status, s_date)
	VALUES
	(
	<cfif FORM.userFname NEQ "">'#Trim(FORM.userFname)#'<cfelse>NULL</cfif>,
	<cfif FORM.userLname NEQ "">'#Trim(FORM.userLname)#'<cfelse>NULL</cfif>,
    <cfif FORM.userEmail NEQ "">'#Trim(FORM.userEmail)#@studentaid.psu.edu'<cfelse>NULL</cfif>,
    <cfif FORM.ptype NEQ "">'#Trim(FORM.ptype)#'<cfelse>NULL</cfif>,
	<cfif FORM.pscope NEQ "">'#Trim(FORM.pscope)#'<cfelse>NULL</cfif>,
	<cfif FORM.ptitle NEQ "">'#Trim(FORM.ptitle)#'<cfelse>NULL</cfif>,
    <cfif FORM.pdesc NEQ "">'#Trim(FORM.pdesc)#'<cfelse>NULL</cfif>,
    <cfif FORM.pdue NEQ "">'#Trim(FORM.pdue)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_fname NEQ "">'#Trim(FORM.w_fname)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_lname NEQ "">'#Trim(FORM.w_lname)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_email NEQ "">'#Trim(FORM.w_email)#'<cfelse>NULL</cfif>,
    <cfif FORM.status NEQ "">'#Trim(FORM.status)#'<cfelse>NULL</cfif>,
    '#Trim(FORM.s_date)#'
	)
</cfquery> 

<!--- create a session variable for this user. You must have your APPLICATION PAGE set up before you set session variables --->
<cflock timeout="500" throwontimeout="no" type="exclusive" scope="session">
<cfset session.userFname = #FORM.userFname#>
<cfset session.userLname = #FORM.userLname#>
<cfset session.userEmail = #FORM.userEmail#>
<cfset session.ptype = #FORM.ptype#>
<cfset session.pscope = #FORM.pscope#>
<cfset session.ptitle = #FORM.ptitle#>
<cfset session.pdesc = #FORM.pdesc#>
<cfset session.pdue = #FORM.pdue#>
</cflock>


<cfmail to="#session.userEmail#@studentaid.psu.edu" from="gto1@studentaid.psu.edu" subject="Your Work Ticket Confirmation" type="html">
<div class="text_main"><br />
#session.userFname#,
<br /><br />
Thank you for taking the time to submit a project ticket to the Communications and Student Services team in The Office of Student Aid. Please review your ticket detail for accuracy and keep this document for your records. We will be in touch with you concerning your project as soon as possible.
<br /><br />
<table class="text_main" width="550px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Project Ticket Details:</b></span></td></tr>
<tr><td width="200px"><strong>Requested:</strong></td><td width="350px">#session.userFname# #session.userLname#</td></tr>
<tr><td><b>On:</b></td><td>#DateFormat(FORM.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#session.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#session.pscope#</td></tr>
<tr><td><strong>Title:</strong></td><td>#session.ptitle#</td></tr>
<tr><td><strong>Description:</strong></td><td>#session.pdesc#</td></tr> 
<tr><td><strong>Requested Due Date:</strong></td><td>#session.pdue#</td></tr></table>
<br /><br />

Thank you,<br />
The Communications and Student Services Team<br />
863-0792<br />

</div>
</cfmail>


Redirecting...
<cflocation url="confirmation.cfm" addtoken="yes">
<cfabort>
</cfif>
<!--- ===========/OF ACTION SECTION================ --->

<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Work Ticket Request Form - Communication & Student Services</td></tr>
<tr><td style="font-size:12px;">Please fill out this form in order to submit a work ticket to the Office of Student Aid Communication & Student Services team. Upon completion of this form you will receive a summary of your work ticket and our team will be notified. We  will be in contact with you as soon as possible. Thank you.</td></tr>
<tr height="20px"><td></td></tr>

<tr><td>
<cfform  name="new_insert"  method="post"  action="#cgi.SCRIPT_NAME#">
<fieldset border="1px" bordercolor="#006633" style="background:#ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:25px; width:700px">

<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #3399FF; font-weight: bold">WORK TICKET REQUEST FORM</span></legend>

<p>1. What is your name? &nbsp; <cfinput type="text" name="userFname" value="(first)" size="20" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)">
&nbsp; <cfinput type="text" name="userLname" value="(last)" size="20" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)"></p>

<p>2. What is your email? &nbsp; <cfinput type="text" name="userEmail" value="(abc123)" size="7" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)"> @studentaid.psu.edu</p>

<p>
3. What type of project are you requesting?  &nbsp; 
<cfinput type="radio" name="ptype" value="Web">Web &nbsp; 
<cfinput type="radio" name="ptype" value="Intranet">Intranet &nbsp; 
<cfinput type="radio" name="ptype" value="Print">Print &nbsp; 
<cfinput type="radio" name="ptype" value="Other">Other&nbsp;</p><p>
4. What is the scope of this project?  &nbsp; 
<cfinput type="radio" name="pscope" value="Minor">Minor Edits / Updates &nbsp; 
<cfinput type="radio" name="pscope" value="Major">Major Edits / Updates  &nbsp; 
<cfinput type="radio" name="pscope" value="New">New &nbsp; 
<cfinput type="radio" name="pscope" value="Other">Other &nbsp; 
</p><p>
5. Please give your project a title: &nbsp;  
<cfinput type="text" name="ptitle" size="30" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999;">
</p><p>
6. Please supply a brief project description. <br>
<textarea name="pdesc" style="width:350px;border-style:dashed; border-width:thin; border-color:#999999;"></textarea>
</p><p>
7. When would you like this project to be completed? &nbsp; 
<cfinput type="text" name="pdue" size="12" maxlength="255" value="(MM/DD/YY)" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)">
</p>
<p>
<cfinput type="hidden" name="w_fname" value="NA">
<cfinput type="hidden" name="w_lname" value="NA">
<cfinput type="hidden" name="w_email" value="NA">
<cfinput type="hidden" name="status" value="1">
<cfinput type="hidden" name="s_date" value="#DateFormat(now(), 'mm/dd/yyyy')#">
<cfinput type="reset" name="Clear" value="Clear">
<cfinput type="submit" name="Insert" value="Submit">
</cfform>
</p>
</fieldset>
</td></tr>
<cfinclude template="ap_footer.cfm">