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
<!--<cferror type="exception" template="error.cfm" exception="any"> -->
<cferror type="REQUEST" template="error.cfm" mailto="you@you.com"> 

