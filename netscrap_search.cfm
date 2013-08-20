<CFSET DATASOURCE="netscrap">

<HTML>
	<HEAD>
		<META NAME="Author" CONTENT="Search Results">
		<TITLE>NetScrap(TM) Search Results</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" TEXT="#000000" LINK="#5678AF" VLINK="#888888" ALINK="#FF0000">

<CENTER>
	<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=0 BGCOLOR="#000000" WIDTH=600><TR><TD>
		<CENTER>
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><TD>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=#FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">NetScrap(TM)</A> &nbsp; : &nbsp; Search Results &nbsp; : &nbsp;
				</FONT>
				</TD></TR>
			</TABLE>
		</CENTER>
	<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 BGCOLOR="#FFFFFF" WIDTH=598><TR><TD>

			<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<IMG SRC="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

		<P ALIGN=RIGHT>
		<FONT FACE="ARIAL BLACK" SIZE=5>Search Results</FONT>
		</P>
<CFSET netscrap_search.RECORDCOUNT=0>
<!---
				<CFSEARCH
					COLLECTION="chrisg"
					NAME="netscrap_search"
					TYPE="SIMPLE"
					CRITERIA="#Lcase(form.criteria)#"
				></CFSEARCH>

					<CFOUTPUT>
						<P>
						<FONT FACE="ARIAL,GENEVA" SIZE=-1>
						Your search for	<FONT COLOR="##FF0000">#form.criteria#</FONT>
						found <B>#netscrap_search.recordcount#</B> matches.
						</FONT>
						</P>
					</CFOUTPUT>
					<CFOUTPUT QUERY="netscrap_search">
						<UL>
						<P>
						<DT><FONT FACE="ARIAL,GENEVA" SIZE=-1><A HREF="./netscrap_detail.cfm?scrap_id=#netscrap_search.KEY#"><B>#netscrap_search.TITLE#</B></A>
						<DD>Score: #netscrap_search.SCORE#</FONT>
						<P>
						</UL>
					</CFOUTPUT>
					<CFOUTPUT>
						<P>
						<FONT FACE="ARIAL,GENEVA" SIZE=-1>
						We also tried a literal search for <FONT COLOR="##FF0000">#form.criteria#</FONT>:
						</FONT>
						</P>
					</CFOUTPUT>
--->
				<cfquery name="netscrap_search2" datasource="#DATASOURCE#">
					SELECT      scrap_id, scrap_title, scrap_category
					FROM         netscrap_articles
					WHERE
					(scrap_title LIKE '%#form.criteria#%'
					OR scrap_title LIKE '#form.criteria#'
					OR scrap_keywords LIKE '#form.criteria#'
					OR scrap_keywords LIKE '%#form.criteria#%'
					OR scrap_owner LIKE '%#form.criteria#%'
					OR scrap_owner LIKE '#form.criteria#')
					AND
					(scrap_category NOT IN ('TEMP','SCAM'))
				</cfquery>
					<CFOUTPUT QUERY="netscrap_search2">
						<UL>
						<P>
						<DT><FONT FACE="ARIAL,GENEVA" SIZE=-1><A HREF="./netscrap_detail.cfm?scrap_id=#scrap_id#"><B>#scrap_title#</B></A>
						<DD>Score: dunno. </FONT>
						<P>
						</UL>
					</CFOUTPUT>

						<CFIF (#netscrap_search2.RECORDCOUNT# IS 0) OR (#netscrap_search.RECORDCOUNT# IS 0)>
						<P>
						<FONT FACE="ARIAL,GENEVA" SIZE=-1>
						We couldn't find many NetScrap(TM) articles that meet your Search Terms.
						It's not you. This search engine is pretty lame. We'll fix it up soon
						enough.	Care to try again?
						</FONT>
						</P>
						</CFIF>

			<FONT FACE="ARIAL,GENEVA" SIZE=-1>
				<FORM ACTION="./netscrap_search.cfm" METHOD="POST" ENCTYPE="multipart/form-data">
				<INPUT TYPE="Text" NAME="criteria" VALUE="<CFOUTPUT>#form.criteria#</CFOUTPUT>" size="30" maxlength="30">
				<INPUT TYPE="Submit" NAME="Netscrap_Search" VALUE="Search">
				</FORM>
			</FONT>

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

