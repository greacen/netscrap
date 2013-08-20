			<CFIF PARAMETEREXISTS(SCRAP_ID) IS 0>
				<CFLOCATION URL="/netscrap.cfm">
			</CFIF>
			
			<CFQUERY NAME="get_scrap_detail" DATASOURCE="netscrap">
				SELECT     scrap_id, scrap_title, scrap_category
				FROM       netscrap_articles
				WHERE      scrap_id = #url.scrap_id#
			</CFQUERY>
			<CFIF GET_SCRAP_DETAIL.RECORDCOUNT IS 0>
				<CFLOCATION URL="/netscrap.cfm">
			</CFIF>



<HTML>
	<HEAD>
		<META NAME="Author" CONTENT="Mailtool">
		<TITLE>NetScrap(TM) Mailtool</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" TEXT="#000000" LINK="#5678AF" VLINK="#888888" ALINK="#FF0000">

<CENTER>
	<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=0 BGCOLOR="#000000" WIDTH=600><TR><TD ALIGN=CENTER>
	<CFOUTPUT QUERY="get_scrap_detail">
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><TD>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=##FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">Netscrap(TM)</A> &nbsp; : &nbsp; <A HREF="./netscrap.cfm?cat_show=#URLEncodedFormat(scrap_category)#">#scrap_category#</A> &nbsp; : &nbsp; <A HREF="./netscrap_detail.cfm?scrap_id=#scrap_id#">Netscrap ###scrap_id#</A>  &nbsp; : &nbsp; MailTool &nbsp; : &nbsp; 
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

<CFOUTPUT QUERY="get_scrap_detail">
<FORM ACTION="./netscrap_mailtool_send.cfm" METHOD="POST" ENCTYPE="multipart/form-data">
	<INPUT TYPE="hidden" NAME="scrap_id" value="#scrap_id#">
	<INPUT TYPE="hidden" NAME="mailtool_sender_name_required" value="You MUST enter your name">
	<INPUT TYPE="hidden" NAME="mailtool_sender_email_required" value="You MUST enter your email address">
	<INPUT TYPE="hidden" NAME="mailtool_recip_name_required" value="You MUST enter your friend's name">
	<INPUT TYPE="hidden" NAME="mailtool_recip_email_required" value="You MUST enter your friend's email address">

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

		<P ALIGN=RIGHT>
		<FONT FACE="ARIAL BLACK" SIZE=5>
		MailTool
		</FONT>
		</P>
		
		<P ALIGN=LEFT>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			Mail this thing to your friend. As I pointed out in the Terms of Use part of
			the site, I will log all the messages you mail out, but I will not sell your
			(or your friend's) email address to anyone. Please don't abuse this service. 
		</FONT>
		</P>

		<P ALIGN=LEFT>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			You are about to send the <B>#scrap_title#</B> NetScrap(TM) message to your friend. 
			You must fill out every field on this form. The message is optional. 
		</FONT>
		</P>

		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Your Name:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_sender_name" SIZE="35" <CFIF PARAMETEREXISTS(cookie.cookie_id_name)>VALUE="#cookie.cookie_id_name#"</CFIF> MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Your Email Address:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_sender_email" SIZE="35" <CFIF PARAMETEREXISTS(cookie.cookie_id_email)>VALUE="#cookie.cookie_id_email#"</CFIF>MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Recipient's Name:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_recip_name" SIZE="35" MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>Recipient's Email Address:</FONT></TD><TD><INPUT TYPE="Text" NAME="mailtool_recip_email" SIZE="35" MAXLENGTH="50"></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1>A short message:</FONT></TD><TD><textarea name="mailtool_message" cols="30" rows="3" wrap="PHYSICAL"></textarea></TD></TR>
			<TR VALIGN=TOP><TD><FONT FACE="ARIAL,GENEVA" SIZE=-1></FONT></TD><TD><input type="Submit" name="MAILIT" value="SENDITOFF!"></TD></TR>
		</TABLE>

	</TD></TR></TABLE>
</FORM>
</CFOUTPUT>

<PRE><FONT COLOR=#FFFFFF>
---------------------------------------------------------------------------
75 Chars Wide</FONT></PRE>
<cfinclude template="./netscrap_footer.cfm">
	</TD></TR></TABLE>
</TD></TR></TABLE>
</CENTER>
</BODY>
</HTML>
