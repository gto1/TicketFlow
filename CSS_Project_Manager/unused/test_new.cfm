<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<cfif Isdefined("Form.fieldnames")>
<cfdump var="#form#" label="form scope">
<br><br>
</cfif>

<cfform name="myform" height="200" width="460" format="Flash" skin="HaloBlue">
   <cfformitem type="html" height="20">
      <b>Tell us your preferences</b>
   </cfformitem>
   <!--- Put the pet selectors to the left of the fruit selectors. --->
   <cfformgroup type="hdividedbox" >
   <!--- Group the pet selector box contents, aligned vertically. --->
      <cfformgroup type="VBox"  height="130">
         <cfformitem type="text" height="20">
            Pets:
         </cfformitem>
         <cfformgroup type="vertical" height="80">
            <cfinput type="Radio" name="pets" label="Dogs" value="Dogs"
               checked>
            <cfinput type="Radio" name="pets" label="Cats" value="Cats">
         </cfformgroup>
      </cfformgroup>
         
   <!--- Group the fruit selector box contents, aligned vertically. --->
      <cfformgroup type="VBox" height="130">
         <cfformitem type="text" height="20">
            Fruits:
         </cfformitem>
         <cfformgroup type="tile" height="80" width="190" label="Tile box">
            <--- Flash requires unique names for all controls --->
            <cfinput type = "Checkbox" name="chk1" Label="Apples"
               value="Apples">
            <cfinput type="Checkbox" name="chk2" Label="Bananas"
               value="Bananas">
            <cfinput type="Checkbox" name="chk3" Label="Pears"
               value="Pears">
            <cfinput type="Checkbox" name="chk4" Label="Oranges"
            value="Oranges">
            <cfinput type="Checkbox" name="chk5" Label="Grapes"
               value="Grapes">
            <cfinput type="Checkbox" name="chk6" Label="Cumquats"
               value="Cumquats">
         </cfformgroup>
      </cfformgroup>
   </cfformgroup>
   <cfformgroup type="horizontal">
      <cfinput type="submit" name="submit" width="100" value="Show Results">
      <cfinput type="reset" name="reset" width="100" value="Reset Fields">
   </cfformgroup>
</cfform>

</body>
</html>
