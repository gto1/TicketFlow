<CFAPPLICATION NAME="you-set-this-yourself" 
	CLIENTMANAGEMENT="no"
	SESSIONMANAGEMENT="yes"
    setclientcookies="Yes"
	sessiontimeout="#createtime(0,15,0)#" 
 	applicationtimeout="#CreateTimeSpan(0,10,30,0)#">


<!--- ==OPTIONAL===SET COMMONLY USED VARIABLES FOR APPLICATION==========--->
<cfset request.dsn="you-set-this-yourself">

<!--- ==OPTIONAL======CLEAR ALL SESSION VARIABLES IF PERSON LOGOUTS====== 
<CFIF IsDefined ("url.logout")> 
<cfset structclear(application)>
<cfset structclear(session)>
</CFIF> 
---> 

<!--- PUBLIC SIDE ERROR CATCHING CODE --->
<cferror type="exception" template="error.cfm">
<cferror type="request" template="error_request.cfm"> 


<!--- Get User name --->
<CFLOCK Scope="Application" 
    TIMEOUT="5"
    TYPE="Exclusive">
	<cfoutput>
		<CFIF (#findNoCase("testroot", CF_TEMPLATE_PATH)# neq "0")>
		<CFSET application.TMSDSN = "you-set-this-yourself">
		<cfelse>
		<CFSET application.TMSDSN = "you-set-this-yourself">
		</CFIF>
		</cfoutput>   
</CFLOCK>

<cfparam name="session.username" default="">

<cfoutput>
<cfquery name="get_staffID" datasource="#Application.TMSDSN#">
	SELECT * 
    FROM STAFF 
    WHERE ACCESSID = '#cgi.http_remote_user#'
</cfquery>

<cfset session.username = "#get_staffID.STAFFName#">
</cfoutput>

<cfinclude template="sql.cfm">