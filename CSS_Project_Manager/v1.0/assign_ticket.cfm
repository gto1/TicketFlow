<cfinclude template="header.cfm">

<tr height="10px"><td></td></tr>
<tr height="20px" style="color:#000000; font-weight: bold; font-size: 12px;">
<td align="left">Assign Selected Ticket</td></tr>
<tr height="20px" style="color:#000000; font-size: 10px;">
<td>Use this form to assign the ticket you selected on the previous page.</td></tr>
<tr><td>

<!--- ==========action section================= --->
<cfif IsDefined ("FORM.Update") AND IsDefined("URL.ID")>
<!--- IF ACTORID IS DEFINED,THEN UPDATE RECORD --->
<cfquery name="Edit_Ticket" datasource="#request.dsn#">
	UPDATE T_Project_Manager
		SET 
		w_fname = <cfif FORM.WorkerName NEQ "">'#Trim(FORM.WorkerName)#'<cfelse>NULL</cfif>,
		status = '2'
	WHERE ProjectID = #URL.ID#
</cfquery>
	<p style="font:Arial, Helvetica, sans-serif; font-size:12px;">This ticket has been assigned.</p>
<!--- /UPDATE CODE --->
</td></td></table>
<!--- GO TO CURRENT PAGE IN 0 SECONDS --->
<cfheader name="Refresh" value="2; URL=view_new.cfm">

<cfabort>
</cfif>
<!--- =======END ===action section================= --->

<cfoutput query="Assign_project">
<fieldset border="1px" bordercolor="##006633" style="background:##ffffff; text-align:left; padding:10px; font-family:Arial, Helvetica, sans-serif; font-size:12px; line-height:25px; width:700px">
<legend class="style1"> <span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: ##3399FF; font-weight: bold">Assign Ticket No. #ProjectID#</span> </legend>
<strong>Title</strong> - #ptitle#<br>
<strong>Description</strong> - #pdesc#<br>
<strong>Submitted By</strong> - #userFname# #userLname#<br>
<strong>Requested Due Date</strong> - #pdue#<br>
<strong>Submitted On </strong>- #DateFormat(s_date, "MM/DD/YY")#<br>


<!--- start - Populate a drop down menu with worker names --->
<form action="#cgi.SCRIPT_NAME#?ID=#URL.ID#" method="post">
<select name="WorkerName">
<option value="Giovanna">Giovanna</option>
<option value="Tammy">Tammy</option>
<option value="Tina">Tina</option>
<option value="Brooke">Brooke</option>
<option value="Greg">Greg</option>
</select>
<input type="submit" name="update" value="Assign" style="font-family:Arial, Helvetica, sans-serif; font-size:10px;">
</form>
<!--- end - Populate a drop down menu with worker names --->

</fieldset>
</cfoutput>

