<CFSET DATASOURCE="netscrap">


<CFIF parameterExists(claim_scrap) IS 1>
        <CFQUERY NAME="EnterNewITEM" DATASOURCE="#DATASOURCE#">
                INSERT INTO netscrap_claims
					(scrap_id, claim_date, claim_story, claim_relationship, claim_email)
                VALUES
					('#Trim(form.scrap_id)#', '#Trim(form.claim_date)#', '#Trim(form.claim_story)#', '#Trim(form.claim_relationship)#', '#Trim(form.claim_email)#')
        </CFQUERY>
		<CFLOCATION URL="/netscrap_thanks.cfm?for=claim">
<CFELSE>

			<CFIF PARAMETEREXISTS(SCRAP_ID) IS 0>
				<CFLOCATION URL="./netscrap.cfm">
			</CFIF>

			<CFQUERY NAME="get_scrap_detail" DATASOURCE="#DATASOURCE#">
				SELECT     scrap_id, scrap_title, scrap_category, scrap_owner
				FROM       netscrap_articles
				WHERE      scrap_id = #url.scrap_id#
			</CFQUERY>
			<CFIF GET_SCRAP_DETAIL.RECORDCOUNT IS 0>
				<CFLOCATION URL="./netscrap.cfm">
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
		<TITLE>NetScrap(TM) Thanks!</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" text="#000000" link="#5678AF" VLINK="#888888" alink="#FF0000">

<CENTER>
	<table border=0 cellpadding=1 cellspacing=0 bgcolor="#000000" width=600><TR><TD ALIGN=CENTER>
	<CFOUTPUT QUERY="get_scrap_detail">
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><TD>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=##FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">Netscrap(TM)</A> &nbsp; : &nbsp; <A HREF="./netscrap.cfm?cat_show=#URLEncodedFormat(scrap_category)#">#scrap_category#</A> &nbsp; : &nbsp; <A HREF="./netscrap_detail.cfm?scrap_id=#scrap_id#">Netscrap ###scrap_id#</A>  &nbsp; : &nbsp; Claim This Scrap &nbsp; : &nbsp;
				</FONT>
				</TD></TR>
			</TABLE>
	</CFOUTPUT>
	<table border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF" width=598><TR><TD>

		<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<IMG SRC="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

		<P ALIGN=RIGHT>
		<FONT FACE="ARIAL BLACK" SIZE=5>Claim This Scrap</FONT>
		</P>

	<CFOUTPUT QUERY="get_scrap_detail">
		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		So-
		</FONT>
		</P>

		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		You think you know something about the person who wrote or owns the
		NetScrap(TM) article titled, <b>#scrap_title#</b>?
		</FONT>
		</P>

		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		We want to know about it. NetScrap(TM)'s mission is to reunite
		jokes like this with their creators. These jokes have probably
		been floating around the net for years. Help us out by telling
		us <b>everything</b> you know.
		</FONT>
		</P>

		<CFIF #scrap_owner# IS NOT "">
			<P>

			<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			We Currently have the following info about this article:
			<UL>
			<b>#scrap_owner#</b>
			</UL>
			</FONT>
			</P>
		</CFIF>

		<TABLE CELLPADDING=3 CELLSPACING=0 BORDER=0>
		<form action="/netscrap_credit.cfm" method="POST" enctype="multipart/form-data" enablecab="Yes" name="netscrap_query_edit">
			<input type="Hidden" name="claim_date" value="#DateFormat("#Now()#", "mm/dd/yyyy")#">
			<input type="Hidden" name="scrap_id" value="#scrap_id#">
			<INPUT TYPE="hidden" Name="claim_email_required" Value="You must enter a your email address">
			<INPUT TYPE="hidden" Name="claim_story_required" Value="You must provide the details you know...">
			<INPUT TYPE="hidden" Name="claim_relationship_required" Value="You must provide the details or your relationship to the joke or author">
					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>What's your story?</b> Include all Copyright information if possible.</FONT><BR>
							<TEXTAREA NAME="claim_story" ROWS=5 COLS=46 WRAP=PHYSICAL></TEXTAREA>
						</TD>
					</TR>
					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Who the heck are you?</b> Explain your expertise or relationship to the joke or writer. </FONT><BR>
							<TEXTAREA NAME="claim_relationship" ROWS=5 COLS=46 WRAP=PHYSICAL></TEXTAREA>
						</TD>
					</TR>
					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>What's your email address?</b> We will not misuse this information, but we may need to contact you to complete our research.</FONT><BR>
							<input type="Text" name="claim_email" size="50" maxlength="100" cols="46"></TEXTAREA>
						</TD>
					</TR>
					<TR VALIGN=TOP>
						<TD COLSPAN=2><input type="Submit" name="claim_scrap" value="          Claim This Scrap          "></TD>
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
</CFIF>