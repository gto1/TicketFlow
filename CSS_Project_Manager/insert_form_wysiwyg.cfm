<!--- IF FORM.INSERT IS DEFINED --->

<cfif IsDefined ("FORM.Insert")>

<!--- query that drops graphagromaniacs admin info into db --->
<cfquery name="DropInNewProject" datasource="#request.dsn#">
INSERT INTO T_Project_Manager (userFname, userLname, userEmail, Team_Name, ptype, pscope, ptitle, pdesc, pdue, w_fname, w_lname, w_email, status, s_date)
	VALUES
	(
	<cfif FORM.userFname NEQ "">'#Trim(FORM.userFname)#'<cfelse>NULL</cfif>,
	<cfif FORM.userLname NEQ "">'#Trim(FORM.userLname)#'<cfelse>NULL</cfif>,
    <cfif FORM.userEmail NEQ "">'#Trim(FORM.userEmail)#@psu.edu'<cfelse>NULL</cfif>,
    <cfif FORM.Team_Name NEQ "">'#Trim(FORM.Team_Name)#'<cfelse>NULL</cfif>,
	<cfif FORM.ptype NEQ "">'#Trim(FORM.ptype)#'<cfelse>NULL</cfif>,
	<cfif FORM.pscope NEQ "">'#Trim(FORM.pscope)#'<cfelse>NULL</cfif>,
	<cfif FORM.ptitle NEQ "">'#Trim(FORM.ptitle)#'<cfelse>NULL</cfif>,
    <cfif FORM.pdesc NEQ "">'#Trim(FORM.pdesc)#'<cfelse>NULL</cfif>,
    <cfif FORM.pdue NEQ "">'#Trim(FORM.pdue)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_fname NEQ "">'#Trim(FORM.w_fname)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_lname NEQ "">'#Trim(FORM.w_lname)#'<cfelse>NULL</cfif>,
    <cfif FORM.w_email NEQ "">'#Trim(FORM.w_email)#'<cfelse>NULL</cfif>,
    <cfif FORM.status NEQ "">'#Trim(FORM.status)#'<cfelse>NULL</cfif>,
  	#Trim(FORM.s_date)#
	)
</cfquery> 
<!--- End - form goes into main database --->


<!--- Start - Notes goes into Notes database --->
<cfquery name="DropInNotes" datasource="#request.dsn#">
INSERT INTO T_Notes (pnotes, n_date)
	VALUES
	(
    <cfif FORM.pnotes NEQ "">'#Trim(FORM.pnotes)#'<cfelse>NULL</cfif>,
    #Trim(FORM.n_date)#
	)
</cfquery> 
<!--- End - Notes goes into Notes database --->


<cfquery name="Get_Last_Ticket_ID" datasource="#request.dsn#" maxrows="1">
    SELECT ProjectID
    FROM T_Project_Manager
    ORDER BY ProjectID DESC;
</cfquery>


<cfif FORM.pnotes NEQ "">
<cfquery name="Get_Last_Note_ID" datasource="#request.dsn#" maxrows="1">
    SELECT Note_ID
    FROM T_Notes
    ORDER BY Note_ID DESC;
</cfquery>

<!--- Start - Update Notes table with ticket ID that is assigned to it --->
<cfquery name="Edit_Last_Note_ID" datasource="#request.dsn#">
	UPDATE T_Notes
	SET 
	Ticket_ID = <cfif Get_Last_Ticket_ID.ProjectID NEQ "">'#Trim(Get_Last_Ticket_ID.ProjectID)#'<cfelse>NULL</cfif>
	WHERE Note_ID = #Get_Last_Note_ID.Note_ID#
</cfquery>
<span class="style2">The new ticket was added and the note with it should be attached by ticket ID.</span>
<!--- End - Update Notes table with ticket ID that is assigned to it  --->
</cfif>


<!--- SET SESSION VARIABLE - create a session variable for this user. You must have your APPLICATION PAGE set up before you set session variables 
<cflock timeout="500" throwontimeout="no" type="exclusive" scope="session">
<cfset session.userFname = #FORM.userFname#>
<cfset session.userLname = #FORM.userLname#>
<cfset session.userEmail = #FORM.userEmail#>
<cfset session.ptype = #FORM.ptype#>
<cfset session.pscope = #FORM.pscope#>
<cfset session.ptitle = #FORM.ptitle#>
<cfset session.pdesc = #FORM.pdesc#>
<cfset session.pdue = #FORM.pdue#>
<cfset session.ProjectID = #Get_LastID.ProjectID#>
</cflock> 
--->

<!---(start) Send an email to user that submitted new ticket --->
<cfmail to="#FORM.userEmail#@psu.edu" from="gmg11@psu.edu" subject="#Get_Last_Ticket_ID.ProjectID#: Your Work Ticket Confirmation" type="html">
#FORM.userFname#,
<br /><br />
Thank you for taking the time to submit a project ticket to the Communications and Student Services team in The Office of Student Aid. Please review your ticket detail for accuracy and keep this document for your records. We will be in touch with you concerning your project as soon as possible.
<br /><br />
<table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Project Ticket Details:</b></span></td></tr>
<tr><td width="250px"><strong>Requested:</strong></td><td width="450px">#FORM.userFname# #FORM.userLname#</td></tr>
<tr><td><strong>Team:</strong></td><td>#FORM.Team_Name#</td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Last_Ticket_ID.ProjectID#</td></tr>
<tr><td><b>Submitted:</b></td><td>#TimeFormat(FORM.s_date, 'hh:mm')# on #DateFormat(FORM.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#FORM.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#FORM.pscope#</td></tr>
<tr><td><strong>Title:</strong></td><td>#FORM.ptitle#</td></tr>
<tr><td><strong>Description:</strong></td><td>#FORM.pdesc#</td></tr>
<cfif FORM.pnotes NEQ ""><tr><td><strong>Notes:</strong></td><td>#FORM.pnotes#</td></tr></cfif>
<tr><td><strong>Due Date:</strong></td><td>#FORM.pdue#</td></tr></table>
<br /><br />
Thank you,<br />
The Communications and Student Services Team<br />
863-0792<br />
</cfmail>
<!---(end) Send an email to user that submitted new ticket --->


<!---(start) Send an email to GIOVANNA for new ticket --->
<cfmail to="gmg11@psu.edu" from="#FORM.userEmail#@psu.edu" subject="A new work ticket has been submitted" type="html">
A new work order ticket has been submitted via the Project Tracker.
<br /><br />
<table width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>Project Ticket Details:</b></span></td></tr>
<tr><td width="250px"><strong>Requested By:</strong></td><td width="450px">#FORM.userFname# #FORM.userLname#</td></tr>
<tr><td><strong>Team:</strong></td><td>#FORM.Team_Name#</td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Last_Ticket_ID.ProjectID#</td></tr>
<tr><td><b>On:</b></td><td>#DateFormat(FORM.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#FORM.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#FORM.pscope#</td></tr>
<tr><td><strong>Title:</strong></td><td>#FORM.ptitle#</td></tr>
<tr><td><strong>Description:</strong></td><td>#FORM.pdesc#</td></tr> 
<cfif FORM.pnotes NEQ ""><tr><td><strong>Notes:</strong></td><td>#FORM.pnotes#</td></tr></cfif>
<tr><td><strong>Due Date:</strong></td><td>#FORM.pdue#</td></tr></table>
<br /><br />

To view and / or assign this ticket, <a href="https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/view_new.cfm">visit the Project Managment Application</a>.
<br /><br />
If you have any trouble clicking on the live link above, please copy and paste this url into your web browser:<br />
https://intranet.osa.psu.edu/intranet/cfdocs/CSS_Project_Manager/view_new.cfm
<br /><br />
</cfmail>
<!---(end) Send an email to Communication and Student Service Team for new ticket --->


<!-- confirmation page -->
<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Thank You</td></tr>
<tr height="20px" style="color:#000000; font-size: 12px;">
<td>Your work ticket has been successfully submitted. The details are below.<br /><br />



<cfoutput><table class="text_main" width="700px" border="1" bordercolor="##999999" cellpadding="3px" cellspacing="0">
<tr><td colspan="2" bgcolor="##333333"><span style="color: ##FFFFFF"><b>YOUR REQUEST DETAILS:</b></span></td></tr>
<tr><td width="200px"><strong>Requested:</strong></td><td width="500px">#FORM.userFname# #FORM.userLname#</td></tr>
<tr><td><strong>Team:</strong></td><td>#FORM.Team_Name#</td></tr>
<tr><td><strong>Ticket No.:</strong></td><td>#Get_Last_Ticket_ID.ProjectID#</td></tr>
<tr><td><b>Submitted:</b></td><td>#TimeFormat(FORM.s_date, 'hh:mm')# on #DateFormat(FORM.s_date, 'mm/dd/yyyy')#</td></tr>
<tr><td><strong>Type:</strong></td><td>#FORM.ptype#</td></tr>
<tr><td><strong>Scope:</strong></td><td>#FORM.pscope#</td></tr>
<tr><td><strong>Title:</strong></td><td>#FORM.ptitle#</td></tr>
<tr><td><strong>Description:</strong></td><td>#FORM.pdesc#</td></tr>
<cfif FORM.pnotes NEQ ""><tr><td><strong>Notes:</strong></td><td>#FORM.pnotes#</td></tr></cfif>
<tr><td><strong>Due Date:</strong></td><td>#FORM.pdue#</td></tr></table>
</cfoutput>


<br /><br />
<span style="color: #999999; font-style:italic;">What would you like to do now?..</span><br />
<br />
<a href="insert.cfm">Submit another ticket</a> | <a href="https://intranet.osa.psu.edu/intranet/index.html" name="OSA Home">OSA Intranet Home</a></td></tr>
<tr height="20px"><td></td></tr>

<tr><td align="left">

</td></tr>
<cfinclude template="ap_footer.cfm">
<cfabort>
</cfif>
<!--- ===========/OF ACTION SECTION================ --->

<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Work Ticket Request Form - Communication & Student Services</td></tr>
<tr><td style="font-size:12px;">This form is to be used to make work requests for 1. public Web, 2. Intranet (internal web), 3. email,  4. eLion Demo, 5. eLion help, and 6. print to the Communications and Student Services Team. (For mainframe, eLion, and other programming and/or computer services related projects, please <a href="https://intranet.osa.psu.edu/intranet/compsvcs/compsvcs.html">click here</a>.) Thank you.</td></tr>
<tr height="20px"><td></td></tr>

<tr><td align="center">
<cfform name="new_insert"  method="post"  action="#cgi.SCRIPT_NAME#">
<fieldset border="1px" bordercolor="#006633" style="background:#ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:25px; width:700px">

<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #3399FF; font-weight: bold">TASK & PROJECT REQUEST FORM</span></legend>

<!--<p style="color: #FF0000">*All fields are required.</p> -->

<p>1. Requested by: &nbsp; First: <cfinput type="text" name="userFname" size="20" maxlength="25" required="yes" validate="noblanks" message="Please enter your first name." style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)">

&nbsp; Last: <cfinput type="text" name="userLname" required="yes" validate="noblanks" message="Please enter your last name."  size="20" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)"></p>

<p>2. User ID: (ex. "abc123" only) &nbsp; <cfinput type="text" name="userEmail" required="yes" validate="noblanks" message="Please enter your email." size="7" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;"> @psu.edu</p>


<p>3. Indicate your team: 
<cfquery name="Get_Teams" datasource="#Request.dsn#">
SELECT *
FROM T_Teams
</cfquery>

<!--- start - Populate a drop down menu with team names --->
<select name="Team_Name">
<cfloop query="Get_Teams">
<cfoutput><option value="#Team_Name#">#Team_Name#</option></cfoutput>


</cfloop>
</select>
<!--- end - Populate a drop down menu with team names --->
</p>


<p>4. What type of project is this?  &nbsp; 
<cfinput type="radio" name="ptype" value="Web">Public Web &nbsp; 
<cfinput type="radio" name="ptype" value="Intranet">Intranet &nbsp; 
<cfinput type="radio" name="ptype" value="eLion_Demo">eLion Demo &nbsp; 
<cfinput type="radio" name="ptype" value="Email">Email &nbsp; 
<cfinput type="radio" name="ptype" value="Print">Print</p>

<p>5. What is the scope of this project?  &nbsp; 
<cfinput type="radio" name="pscope" value="Minor">Minor Changes &nbsp; 
<cfinput type="radio" name="pscope" value="Major">Major Changes  &nbsp; 
<cfinput type="radio" name="pscope" value="New">New</p>

<p>6. Give the project a title: &nbsp;  
<cfinput type="text" name="ptitle" required="yes" validate="noblanks" message="Please enter a project title." size="50" maxlength="50" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)">
</p>

<p align="justify">7. Supply a brief project description:<br>
<span class="note"><b>Note:</b> Please include here all necessary information to complete the task you are requesting (e.g. URLs to web screens, locations of Word docs on the F/Transf/General drive, etc.) If you have necessary paper or electronic documents with this request that cannot be included in the description box here please see the directions for submitting these supplemental materials below.</span><br />

<textarea id="description" name="pdesc" style="width:690px;height:150px;"></textarea>

<!--- <cftextarea name="pdesc" required="yes" validate="noblanks" message="Please provide a project description." style="width:550px;border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)"></cftextarea> --->
</p>

<p>

<div class="supp_mats">
<b>SUPPLEMENTAL MATERIALS</b> - What to do with them...<br /><br />

<u>Paper Documents</u> - 
If you have paper supporting documents such as printed Web screens with marked up edits:<br />
<ol>
<li>Write your name AND the ticket number on the paper (you will receive the ticket number upon submitting this ticket).</li>
<li>Place the paper with ticket number on it in the mailbox marked "Communication Team Requests" in mail/imaging (317).</li>
</ol>

<br />
<u>Electronic Documents</u> - 
If you have electronic supporting documents such as Word documents with marked up edits:<br />
<ol>
<li>Type your name AND the ticket number in the name of each file (you will receive the ticket number upon submitting this work order ticket).</li>
<li>Place each file into the proper folders by type of project in F:\Transfer\General\Communication Project Requests</li>
</ol>
</div>

</p>

<p align="justify">8. What is your deadline? <span class="note">Enter <u>one</u> choice (A, B, or C) for the deadline.<br />
<b>Note:</b>  This is the date that the project must be finished. Generally you will need to give a minimum of a two week notice for any project. If you do not necessarily have a due date select "No Deadline." Use "Stat" only for the highest priority tasks that have to be completed immediately, such as a broken link on the public Web site or a timely news item request on the home page. Stat cannot be used for quick turnaround on general projects that were not given the proper planning time as mentioned above.</span><br />

<b>A.</b> Date: (format only "MM/DD/YY")&nbsp; <cfinput type="text" name="pdue" required="yes" validate="date" message="Please enter a proposed completion date in the proper format." size="12" maxlength="255" style="border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)"> &nbsp; &nbsp; &nbsp;

<b>B.</b> <cfinput type="radio" name="pdue" value="NA">No Deadline 
 &nbsp; &nbsp; &nbsp;
<b>C.</b> <cfinput type="radio" name="pdue" value="Stat">Stat<br />

</p>

<p>9. Please supply any additional notes you would like to include for this ticket. <br>
<cftextarea name="pnotes" required="no" style="width:350px;border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;" onFocus="clearText(this)" onBlur="clearText(this)"></cftextarea>
</p>


<p>
<cfinput type="hidden" name="w_fname" value="NA">
<cfinput type="hidden" name="w_lname" value="NA">
<cfinput type="hidden" name="w_email" value="NA">
<cfinput type="hidden" name="status" value="1">
<cfinput type="hidden" name="s_date" value="#now()#">
<cfinput type="hidden" name="n_date" value="#now()#">
<cfinput type="reset" name="Clear" value="Clear">
<cfinput type="submit" name="Insert" value="Submit">
</cfform>
</p>
</fieldset>
</td></tr></table>