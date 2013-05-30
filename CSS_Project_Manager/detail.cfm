<cfinclude template="header.cfm">

<!--- START - IF FORM.ADD IS DEFINED --->
<cfif IsDefined ("FORM.Add")>
<!--- Start - Notes goes into Notes database --->
<cfquery name="DropInNotes" datasource="#request.dsn#">
INSERT INTO T_Notes (Ticket_ID, n_date, pnotes)
	VALUES
	(
    #Trim(URL.ID)#,
	#Trim(FORM.n_date)#,
	<cfif FORM.pnotes NEQ "">'#Trim(FORM.pnotes)# [#get_staffID.STAFFName#]'<cfelse>NULL</cfif>    
	)
</cfquery> 
<!--- End - Notes goes into Notes database --->
</cfif>
<!--- END - IF FORM.INSERT IS DEFINED --->

<cfoutput query="Get_Project_detail" maxrows="1">
<tr height="10px"><td></td></tr>
<tr height="20px"><td align="left">
<span class="status_head">No. #ProjectID#: "#ptitle#"</span></td></tr>
</table>


<table width="950px" border="1px" bordercolor="##CCCCCC" cellpadding="5px" cellspacing="0px">
<tr height="20px" bgcolor="##333333" style="color:##FFFFFF; font-weight: bold; font-size: 12px;">
<td>Ticket Details</td></tr>

<!--- <tr><td align="left" valign="top" style="font-size: 10px;">Ticket No.: #ProjectID#</td></tr> --->

<tr><td align="left" valign="top" style="font-size: 10px;">Description: #pdesc#</td></tr>

<tr><td align="left" valign="top" style="font-size: 10px;">Requested: <a href="mailto:#userEmail#">#userFname# #userLname#</a> at #TimeFormat(s_date, 'h:mm tt')# on #DateFormat(s_date, "dddd MM/DD/YY")#</td></tr>

<tr><td align="left" valign="top" style="font-size: 10px;">Type: #ptype#</td></tr>

<tr><td align="left" valign="top" style="font-size: 10px;">Scope: #pscope#</td></tr>

<tr><td align="left" valign="top" style="font-size: 10px;">Deadline: #pdue#</td></tr>

<tr><td align="left" valign="top" style="font-size: 10px;">Owner(s): 
<cfif '#w_fname#' NEQ ''>&bull; #w_fname#</cfif>
<cfif '#owner2#' NEQ ''> &bull; #owner2#</cfif>
<cfif '#owner3#' NEQ ''> &bull; #owner3#</cfif>
<cfif '#owner4#' NEQ ''> &bull; #owner4#</cfif>


<!--- Allow only Role 1 to assign or edit --->
<cfif '#check_role.Role#' NEQ '' AND '#check_role.Role#' EQ 1>

<!---  if there are 4 owners allow to edit, if not yet 4 allow to add or edit --->

<cfif '#w_fname#' NEQ '' AND '#owner2#' NEQ '' AND '#owner3#' NEQ ''  AND '#owner4#' NEQ ''>
&nbsp; <a href="edit_status.cfm?ID=#ProjectID#" title="Edit Owner">[Edit]</a>

<cfelseif '#w_fname#' EQ '' AND '#owner2#' EQ '' AND '#owner3#' EQ ''  AND '#owner4#' EQ ''>
&nbsp; Not yet assigned. <a href="edit_status.cfm?ID=#ProjectID#" title="Edit Owner">[Add]</a>

<cfelseif '#w_fname#' EQ '' OR '#owner2#' EQ '' OR '#owner3#' EQ ''  OR '#owner4#' EQ ''>
&nbsp; <a href="edit_status.cfm?ID=#ProjectID#" title="Edit or Add Owner">[Edit / Add]</a>

</cfif>


</cfif>
<br />Each ticket can have up to four (4) owners assigned to it.
</td></tr>


<cfquery name="Get_Status_of_current" datasource="#Request.dsn#">
SELECT *
FROM T_Statuses
WHERE Status_ID = '#Get_Project_detail.Status#'
</cfquery>

<tr><td align="left" valign="top" style="font-size: 10px;">Status: 
<cfif #status# EQ 1><span style="color: ##FF0000">New</span> &nbsp; 

<!--- Allow only Role 1 to assign or edit --->
<cfif '#check_role.Role#' NEQ "" AND '#check_role.Role#' EQ 1>
<a href="edit_status.cfm?ID=#ProjectID#" title="Assign Ticket">[Assign]</a>
</cfif>

<cfelse>#Get_Status_of_current.status# &nbsp; 

<!--- Allow only Role 1 to assign or edit --->
<cfif '#check_role.Role#' NEQ "" AND '#check_role.Role#' EQ 1>
<a href="edit_status.cfm?ID=#ProjectID#" title="Update Ticket Status">[Update]</a>
</cfif>
</cfif>

</td></tr>


<tr><td align="left" valign="top" style="font-size: 10px;" bgcolor="##99ccff">NOTES:  [<a href="#cgi.SCRIPT_NAME#?ID=#URL.ID#&Add=Yes">Add New</a>] &nbsp; [<a href="#cgi.SCRIPT_NAME#?ID=#URL.ID#">Close Form</a>]</td></tr>


<cfquery name="Get_notes" datasource="#request.dsn#">
SELECT * 
FROM T_Notes
Where Ticket_ID = #URL.ID#
ORDER BY n_date DESC
</cfquery>


<!---Start - If Add New is clicked to add a note --->
<cfif IsDefined ("URL.Add") AND #URL.Add# IS "Yes">
<tr><td align="left" valign="top" style="font-size: 10px;">
<font color="##CC3333">ADD A NOTE:</font> Please add a new note here:
<br />
<cfform><cftextarea name="pnotes" required="yes" validate="noblanks" message="Please provide your updated note." style="width:350px;border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;"></cftextarea><br />
<cfinput type="hidden" name="n_date" value="#now()#">
<cfinput type="submit" name="Add" value="Add" style="font-family:Arial, Helvetica, sans-serif; font-size: 10px; height: 18px;">
</cfform>
</td></tr>
</cfif>
<!---End - If Add New is clicked to add a note --->

<!---Start - If Edit is clicked to edit the note 
<cfif IsDefined ("URL.Edit") AND #URL.Edit# IS "Yes">
<tr><td align="left" valign="top" style="font-size: 10px;">
<font color="##CC3333">EDIT NOTE:</font> Please edit the note here:
<br />
<cfform><cftextarea name="edit_note" required="yes" validate="noblanks" message="Please provide your updated note." style="width:350px;border-style:dashed; border-width:thin; border-color:##999999; font-size:12px; color:##666666;"><cfoutput>#Get_notes.pnotes#</cfoutput></cftextarea><br />
<cfinput type="hidden" name="n_date" value="#now()#">
<cfinput type="submit" name="Edit" value="Edit" style="font-family:Arial, Helvetica, sans-serif; font-size: 10px; height: 18px;">
</cfform>
</td></tr>
</cfif>
End - If Edit is clicked to edit the note --->
</cfoutput>

<cfoutput query="Get_notes">
<TR BGCOLOR=###IIF(currentrow MOD 2, DE ('FFFFFE'), DE ('D5DEE5'))#><td align="left" valign="top" style="font-size: 10px;">
#Get_notes.pnotes# <br />
#DateFormat(Get_notes.n_date, "dddd MM/DD/YY")#, #TimeFormat(Get_notes.n_date, 'h:mm tt')#</td></tr>
</cfoutput>

<cfif #Get_notes.Note_ID# EQ "">
<tr><td align="left" valign="top" style="font-size: 10px;">
There are no notes at this time for this ticket.</td></tr>
</cfif>

</table>
<!---[<a href="#cgi.SCRIPT_NAME#?ID=#URL.ID#&Edit=Yes">Edit</a>] --->
<!--- end  ticket detail table --->

<cfinclude template="footer.cfm">

</center>
</body>
</html>
