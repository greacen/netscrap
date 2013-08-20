<CFSET DATASOURCE="feedback">

<CFIF parameterExists(scrap_feedback) IS 1>
	<CFSET EMail = "#form.feedback_email#">

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

	<CFIF #EMail_Level# IS "0">
			<cfcookie
				name="cookie_id_name"
				value="#form.feedback_name#"
				expires="NEVER"
			>

			<cfcookie
				name="cookie_id_email"
				value="#form.feedback_email#"
				expires="NEVER"
			>
	</CFIF>

	<CFIF #EMail_Level# IS "0">
<!---
	        <CFQUERY NAME="EnterNewITEM" DATASOURCE="#DATASOURCE#">
	                INSERT INTO feedback_data
						(feedback_date, feedback_site, feedback_type, feedback_page, feedback_email, feedback_name, feedback_message, feedback_browser)
	                VALUES
						('#Trim(form.feedback_date)#', '#Trim(form.feedback_site)#', '#Trim(form.feedback_type)#', '#Trim(form.feedback_page)#', '#Trim(form.feedback_email)#', '#Trim(form.feedback_name)#', '#Trim(form.feedback_message)#', '#Trim(form.feedback_browser)#')
	        </CFQUERY>
--->
			<CFLOCATION URL="/netscrap_thanks.cfm?for=feedback&email=#URLEncodedFormat(form.feedback_email)#&name=#URLEncodedFormat(form.feedback_name)#">
	</CFIF>
<CFELSE>
		<CFSET EMail_Level = "0">
		<CFSET EMail_Message = "">
</CFIF>

<HTML>
	<HEAD>
		<META NAME="description" CONTENT="NetScrap(TM) is the
		central repository for all the email jokes floating around
		the net. Our goal is to find the people who writes this
		stuff. ">
		<META NAME="keywords" CONTENT="jokes, email, humor, funny,
		laugh, dirty jokes, good, fun, scrap, crap, netscrap,
		NetScrap(TM)">
		<META NAME="Author" CONTENT="Netscrap Thanks!">
		<TITLE>NetScrap(TM) Feedback</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" text="#000000" link="#5678AF" VLINK="#888888" alink="#FF0000">

<CENTER>
	<table border=0 cellpadding=1 cellspacing=0 bgcolor="#000000" width=600><TR><TD ALIGN=CENTER>
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><TD>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=#FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">Netscrap(TM)</A> &nbsp; : &nbsp; Feedback &nbsp; : &nbsp;
				</FONT>
				</TD></TR>
			</TABLE>
	<table border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF" width=598><TR><TD>

		<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<IMG SRC="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

		<P ALIGN=RIGHT>
		<FONT FACE="ARIAL BLACK" SIZE=5>Feedback</FONT>
		</P>

	<CFIF #EMail_Level# GT "0">
		<CFOUTPUT>
		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		For your Email Address you entered: <b>#form.feedback_email#</b><BR>
		<b>Problem:</b> #EMail_Message#<BR>
		</FONT>
		</P>
		</CFOUTPUT>
	<CFELSE>
		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		So-
		</FONT>
		</P>

		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		You got something that you want to say to us? Something that you like?
		Something you don't like? Did you check the FAQ? <i>You know we have to ask you that.</i>
		</FONT>
		</P>

		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		Ok, no problem. We'd love to take a look at anything you want to share.
		</FONT>
		</P>
	</CFIF>

	<CFOUTPUT>

		<TABLE CELLPADDING=3 CELLSPACING=0 BORDER=0>
		<form action="/netscrap_feedback.cfm" method="POST" enctype="multipart/form-data" name="netscrap_query_edit">
			<input type="Hidden" name="scrap_feedback" value="1">
			<input type="Hidden" name="feedback_date" value="#DateFormat("#Now()#", "mm/dd/yyyy")#">
			<input type="Hidden" name="feedback_site" value="NetScrap">
			<INPUT TYPE="hidden" Name="feedback_browser" Value="#HTTP_USER_AGENT#">
			<INPUT TYPE="hidden" Name="feedback_email_required" Value="You must enter a your email address">
			<INPUT TYPE="hidden" Name="feedback_message_required" Value="Hey- gimmie some feedback!">
					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>What kind of message is this?</B></FONT><BR>
							<SELECT NAME="feedback_type">
							<OPTION VALUE="Kudo" SELECTED>Kudo</OPTION>
							<OPTION VALUE="Brokenlink">Broken Link</OPTION>
							<OPTION VALUE="Typo">Typo</OPTION>
							<OPTION VALUE="Suggestion" >Suggestion</OPTION>
							<OPTION VALUE="Ads" >Ads</OPTION>
							<OPTION VALUE="Other">Other</OPTION>
							</SELECT>
						</TD>
					</TR>

					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>The page that made you want to contact us:</B></FONT><BR>
							<INPUT TYPE="TEXT" NAME="feedback_page" VALUE="<cfif #parameterexists(http_referer)#>#http_referer#</CFIF>" SIZE=50 MAXSIZZE=100>
						</TD>
					</TR>


					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Your Name:</B></FONT><BR>
							<INPUT TYPE="TEXT" NAME="feedback_name" VALUE="<CFIF PARAMETEREXISTS(form.feedback_name)>#form.feedback_name#<CFELSE><CFIF PARAMETEREXISTS(cookie.cookie_id_name)>#cookie.cookie_id_name#</CFIF></CFIF>" SIZE=50 MAXSIZZE=100>
						</TD>
					</TR>

					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1 <CFIF #EMail_Level# GT "0">COLOR=##FF0000</CFIF>><b>Your Email Address:</B></FONT><BR>
							<INPUT TYPE="TEXT" NAME="feedback_email" VALUE="<CFIF PARAMETEREXISTS(form.feedback_name)>#form.feedback_email#<CFELSE><CFIF PARAMETEREXISTS(cookie.cookie_id_name)>#cookie.cookie_id_email#</CFIF></CFIF>" SIZE=50 MAXSIZZE=100>
						</TD>
					</TR>


					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>What do you have to say for yourself?</b> Enter it all here. </FONT><BR>
							<TEXTAREA NAME="feedback_message" ROWS=5 COLS=46 WRAP=PHYSICAL></TEXTAREA>
						</TD>
					</TR>
					<TR VALIGN=TOP>
						<TD COLSPAN=2><input type="Submit" name="claim_scrap" value="          FEEDBACK          "></TD>
					</TR>
			</TABLE>

		</FORM>
	</CFOUTPUT>
	</TD></TR></TABLE>


<PRE><FONT COLOR=#FFFFFF>
---------------------------------------------------------------------------
75 Chars Wide</FONT></PRE>
<cfinclude template="./netscrap_footer.cfm">
	</TD></TR></TABLE>
</TD></TR></TABLE>
<cfinclude template="./include_ads.cfm">

</CENTER>
</BODY>
</HTML>
