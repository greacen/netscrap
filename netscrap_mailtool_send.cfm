<CFIF PARAMETEREXISTS(SCRAP_ID) IS 0>
	<CFLOCATION URL="./netscrap.cfm">
</CFIF>

<CFQUERY NAME="get_scrap_detail" DATASOURCE="netscrap">
	SELECT     *
	FROM       netscrap_articles
	WHERE      scrap_id = #form.scrap_id#
</CFQUERY>



<CFSET EMail = #form.mailtool_recip_email#>

<CFIF #EMail# is "">
	<CFSET #EMail_Level# = "1">
	<CFSET #EMail_Message# = "No e-mail address was supplied.">
<CFELSEIF #FindNoCase('@',EMail)# is 0>
	<CFSET #EMail_Level# = "2">
	<CFSET #EMail_Message# = "No @ sign detected.  An @ sign is part of every e-mail address.">
<CFELSEIF #Right(EMail,1)# is "@">
	<CFSET #EMail_Level# = "3">
	<CFSET #EMail_Message# = "An @ sign cannot be the last character of the e-mail address.">
<CFELSEIF #Left(EMail,1)# is "@">
	<CFSET #EMail_Level# = "4">
	<CFSET #EMail_Message# = "An @ sign cannot be the first character of the e-mail address.">
<CFELSEIF #FindNoCase('@',EMail,(FindNoCase('@',EMail) + 1))# is not 0>
	<CFSET #EMail_Level# = "5">
	<CFSET #EMail_Message# = "A valid e-mail address contains only one @ sign.">
<CFELSEIF #FindNoCase('.',Email)# is 0>
	<CFSET #EMail_Level# = "6">
	<CFSET #EMail_Message# = "No period detected.  An e-mail address contains at least one period.">
<CFELSEIF #Right(EMail,1)# is ".">
	<CFSET #EMail_Level# = "7">
	<CFSET #EMail_Message# = "The last character of the e-mail address cannot be a period.">
<CFELSEIF #Left(EMail,1)# is ".">
	<CFSET #EMail_Level# = "8">
	<CFSET #EMail_Message# = "The first character of the e-mail address cannot be a period.">
<CFELSEIF #FindNoCase(',',EMail)# is not 0>
	<CFSET #EMail_Level# = "9">
	<CFSET #EMail_Message# = "A valid e-mail address cannot contain a comma.  If you have a Compuserve account, substitute a period for the comma in your Compuserve ID, like so: <B>12345.6789@compuserve.com</B>.">
<CFELSEIF #FindNoCase(' ',EMail)# is not 0>
	<CFSET #EMail_Level# = "10">
	<CFSET #EMail_Message# = "You cannot have a space as part of a single e-mail address.">
<CFELSEIF #FindNoCase('*',EMail)# is not 0>
	<CFSET #EMail_Level# = "11">
	<CFSET #EMail_Message# = "You cannot have an asterisk in an e-mail address.">
<CFELSEIF #FindNoCase(')',EMail)# is not 0>
	<CFSET #EMail_Level# = "12">
	<CFSET #EMail_Message# = "You cannot have a close parenthesis sign in an e-mail address.">
<CFELSEIF #FindNoCase('(',EMail)# is not 0>
	<CFSET #EMail_Level# = "13">
	<CFSET #EMail_Message# = "You cannot have an open parenthesis sign in an e-mail address.">
<CFELSEIF #FindNoCase(CHR(62),EMail)# is not 0>
	<CFSET #EMail_Level# = "14">
	<CFSET #EMail_Message# = "You cannot have a greater than sign in an e-mail address.">
<CFELSEIF #FindNoCase(CHR(60),EMail)# is not 0>
	<CFSET #EMail_Level# = "15">
	<CFSET #EMail_Message# = "You cannot have a less than sign in an e-mail address.">
<CFELSEIF #FindNoCase(':',EMail)# is not 0>
	<CFSET #EMail_Level# = "16">
	<CFSET #EMail_Message# = "You cannot have a colon in an e-mail address.">
<CFELSEIF #FindNoCase(';',EMail)# is not 0>
	<CFSET #EMail_Level# = "17">
	<CFSET #EMail_Message# = "You cannot have a semicolon in an e-mail address.">
<CFELSEIF #FindNoCase(CHR(34),EMail)# is not 0>
	<CFSET #EMail_Level# = "18">
	<CFSET #EMail_Message# = "You cannot have a double quote in an e-mail address.">
<CFELSE>
	<CFSET #EMail_Level# = "0">
	<CFSET #EMail_Message# = "No problem. This is a good e-mail address.">
</CFIF>




<CFSET EMail2 = #form.mailtool_sender_email#>

<CFIF #EMail2# is "">
	<CFSET #EMail2_Level# = "1">
	<CFSET #EMail2_Message# = "No e-mail address was supplied.">
<CFELSEIF #FindNoCase('@',EMail2)# is 0>
	<CFSET #EMail2_Level# = "2">
	<CFSET #EMail2_Message# = "No @ sign detected.  An @ sign is part of every e-mail address.">
<CFELSEIF #Right(EMail2,1)# is "@">
	<CFSET #EMail2_Level# = "3">
	<CFSET #EMail2_Message# = "An @ sign cannot be the last character of the e-mail address.">
<CFELSEIF #Left(EMail2,1)# is "@">
	<CFSET #EMail2_Level# = "4">
	<CFSET #EMail2_Message# = "An @ sign cannot be the first character of the e-mail address.">
<CFELSEIF #FindNoCase('@',EMail2,(FindNoCase('@',EMail2) + 1))# is not 0>
	<CFSET #EMail2_Level# = "5">
	<CFSET #EMail2_Message# = "A valid e-mail address contains only one @ sign.">
<CFELSEIF #FindNoCase('.',EMail2)# is 0>
	<CFSET #EMail2_Level# = "6">
	<CFSET #EMail2_Message# = "No period detected.  An e-mail address contains at least one period.">
<CFELSEIF #Right(EMail2,1)# is ".">
	<CFSET #EMail2_Level# = "7">
	<CFSET #EMail2_Message# = "The last character of the e-mail address cannot be a period.">
<CFELSEIF #Left(EMail2,1)# is ".">
	<CFSET #EMail2_Level# = "8">
	<CFSET #EMail2_Message# = "The first character of the e-mail address cannot be a period.">
<CFELSEIF #FindNoCase(',',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "9">
	<CFSET #EMail2_Message# = "A valid e-mail address cannot contain a comma.  If you have a Compuserve account, substitute a period for the comma in your Compuserve ID, like so: <B>12345.6789@compuserve.com</B>.">
<CFELSEIF #FindNoCase(' ',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "10">
	<CFSET #EMail2_Message# = "You cannot have a space as part of a single e-mail address.">
<CFELSEIF #FindNoCase('*',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "11">
	<CFSET #EMail2_Message# = "You cannot have an asterisk in an e-mail address.">
<CFELSEIF #FindNoCase(')',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "12">
	<CFSET #EMail2_Message# = "You cannot have a close parenthesis sign in an e-mail address.">
<CFELSEIF #FindNoCase('(',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "13">
	<CFSET #EMail2_Message# = "You cannot have an open parenthesis sign in an e-mail address.">
<CFELSEIF #FindNoCase(CHR(62),EMail2)# is not 0>
	<CFSET #EMail2_Level# = "14">
	<CFSET #EMail2_Message# = "You cannot have a greater than sign in an e-mail address.">
<CFELSEIF #FindNoCase(CHR(60),EMail2)# is not 0>
	<CFSET #EMail2_Level# = "15">
	<CFSET #EMail2_Message# = "You cannot have a less than sign in an e-mail address.">
<CFELSEIF #FindNoCase(':',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "16">
	<CFSET #EMail2_Message# = "You cannot have a colon in an e-mail address.">
<CFELSEIF #FindNoCase(';',EMail2)# is not 0>
	<CFSET #EMail2_Level# = "17">
	<CFSET #EMail2_Message# = "You cannot have a semicolon in an e-mail address.">
<CFELSEIF #FindNoCase(CHR(34),EMail2)# is not 0>
	<CFSET #EMail2_Level# = "18">
	<CFSET #EMail2_Message# = "You cannot have a double quote in an e-mail address.">
<CFELSE>
	<CFSET #EMail2_Level# = "0">
	<CFSET #EMail2_Message# = "No problem. This is a good e-mail address.">
</CFIF>




<HTML>
	<HEAD>
		<CFIF #EMail_Level# IS "0" and #EMail2_Level# IS "0">
		<meta http-equiv="Refresh" content="4; URL=/netscrap.cfm">
		</CFIF>
		<META NAME="Author" CONTENT="Mailtool Results">
		<TITLE>NetScrap(TM) Mailtool Results</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" TEXT="#000000" LINK="#5678AF" VLINK="#888888" ALINK="#FF0000">

<CENTER>
	<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=0 BGCOLOR="#000000" WIDTH=600><TR><TD ALIGN=CENTER>
	<CFOUTPUT QUERY="get_scrap_detail">
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><TD>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=##FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">Netscrap(TM)</A> &nbsp; : &nbsp; <A HREF="./netscrap.cfm?cat_show=#URLEncodedFormat(scrap_category)#">#scrap_category#</A> &nbsp; : &nbsp; <A HREF="./netscrap_detail.cfm?scrap_id=#scrap_id#">Netscrap ###scrap_id#</A>  &nbsp; : &nbsp; MailTool &nbsp; : &nbsp; Results &nbsp; : &nbsp;
				</FONT>
				</TD></TR>
			</TABLE>
	</CFOUTPUT>

	<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF" WIDTH=598><TR><TD>
			<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<IMG SRC="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>


<CFIF #EMail_Level# IS "0" and #EMail2_Level# IS "0">

<cfcookie
	name="cookie_id_name"
	value="#form.mailtool_sender_name#"
	expires="NEVER"
>

<cfcookie
	name="cookie_id_email"
	value="#form.mailtool_sender_email#"
	expires="NEVER"
>

<cffile action="APPEND"
	file="D:\FTP\chrisg2003\Htdocs\admin\netscrap_mailtool.log"
	output="%%#DateFormat(Now(), 'mm-dd-yy')#%%,%%#form.mailtool_sender_email#%%,%%#form.mailtool_recip_email#%%,%%#scrap_id#%%,%%#REMOTE_HOST#%%">

 <cfmail
	 query="get_scrap_detail"
	 to="#form.mailtool_recip_email#"
	 from="scrapmaster@netscrap.com"
	 subject="NetScrap(TM): #scrap_title#"
	 server="scriptmail.intermedia.net">

Hey #form.mailtool_recip_name#:

#form.mailtool_sender_name# (#form.mailtool_sender_email#) has chosen this NetScrap(TM) article to send to you!

From #form.mailtool_sender_name#:
#mailtool_message#

----- Begin NetScrap(TM) -----

#scrap_title#

#scrap_article#

<CFIF #scrap_url_description# IS NOT "">
#scrap_url_description#:
#scrap_url#

</CFIF>
----- End NetScrap(TM) -----

http://www.netscrap.com/netscrap_detail.cfm?scrap_id=#scrap_id#

This NetScrap(TM) message was sent to you from the Mailtool on
http://www.netscrap.com/ NetScrap(TM)'s goal is to collect as much
internet junk (jokes for now) as possible with the hopes of
finding the authors of this stuff. We're just trying to make
sense of all this scrap floating around the net!

Feel free to forward it, but come to http://www.netscrap.com/ and
find something better to send.

<CFIF get_scrap_detail.scrap_owner IS "">
Claim it: Did you do this? Do you own it? Can you prove it?
NetScrap(TM)'s mission is to reunite jokes like this with their
creators.

Take credit for your fine work:
http://www.netscrap.com/netscrap_credit.cfm?scrap_id=#scrap_id#

<CFELSE>
Allegedly perpetrated by:
#get_scrap_detail.scrap_owner#

Do you have more info on the author? Let us know:
http://www.netscrap.com/netscrap_credit.cfm?scrap_id=#scrap_id#

</CFIF>

If you feel this service has been abused, please contact
abuse@netscrap.com with the details of your situation.

</cfmail>
	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

		<P ALIGN=RIGHT>
		<FONT FACE="ARIAL BLACK" SIZE=5>
		Success!
		</FONT>
		</P>

		<P ALIGN=LEFT>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		<CFOUTPUT QUERY="get_scrap_detail">
			Looks like everything worked! We didn't find any trouble with your
			email addresses. Search again for some other great bits
			of NetScrap(TM).
		</CFOUTPUT>
		</FONT>
		</P>

<CFELSE>
<CFOUTPUT QUERY="get_scrap_detail">
<FORM ACTION="./netscrap_mailtool_send.cfm" METHOD="POST" ENCTYPE="multipart/form-data">
	<INPUT TYPE="hidden" NAME="scrap_id" value="#scrap_id#">
	<INPUT TYPE="hidden" NAME="mailtool_sender_name_required" value="You MUST enter your name">
	<INPUT TYPE="hidden" NAME="mailtool_sender_email_required" value="You MUST enter your email address">
	<INPUT TYPE="hidden" NAME="mailtool_recip_name_required" value="You MUST enter your friend's name">
	<INPUT TYPE="hidden" NAME="mailtool_recip_email_required" value="You MUST enter your friend's email address">

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

		<P ALIGN=RIGHT>
		<FONT FACE="ARIAL BLACK" SIZE=5 COLOR=##FF0000>
		ERROR!
		</FONT>
		</P>

		<P ALIGN=LEFT>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			For your Email Address you entered: <b>#form.mailtool_sender_email#</b><BR>
			<b>Problem:</b> #EMail2_Message#
			<P>

			For your Email Address you entered: <b>#form.mailtool_recip_email#</b><BR>
			<b>Problem:</b> #EMail_Message#<BR>
		</FONT>
		</P>

		<P ALIGN=LEFT>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			You are about to send the <B>#scrap_title#</B> NetScrap(TM) message to your friend.
			You must fill out every field on this form with valid information.
			The message is optional.
		</FONT>
		</P>

		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Your Name:</FONT></TD><TD><input type="Text" name="mailtool_sender_name" value="#form.mailtool_sender_name#" size="35" maxlength="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Your Email Address:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_sender_email" value="#form.mailtool_sender_email#" SIZE="35" MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Recipient's Name:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_recip_name" value="#form.mailtool_recip_name#" SIZE="35" MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Recipient's Email Address:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_recip_email" value="#form.mailtool_recip_email#" SIZE="35" MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>A short message:</FONT></TD><TD><textarea name="mailtool_message" cols="30" rows="3" wrap="PHYSICAL">#form.mailtool_message#</textarea></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1></FONT></TD><TD><input type="Submit" name="MAILIT" value=" SENDITOFF!   Again  "></TD></TR>
		</TABLE>
	</FORM>
</CFOUTPUT>
</CFIF>

	</TD></TR></TABLE>
<PRE><FONT COLOR=#FFFFFF>
---------------------------------------------------------------------------
75 Chars Wide</FONT></PRE>
<cfinclude template="./netscrap_footer.cfm">
	</TD></TR></TABLE>
</TD></TR></TABLE>
</CENTER>
</BODY>
</HTML>


