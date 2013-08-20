<!------------------------------
			<CFIF ParameterExists(scrap_id) IS 0>
				<CFLOCATION URL="./netscrap.cfm">
			</CFIF>

			<CFQUERY NAME="get_scrap_detail" DATASOURCE="netscrap">
				SELECT     *
				FROM       netscrap_articles
				WHERE      scrap_id = #url.scrap_id#
			</CFQUERY>
			<CFIF get_scrap_detail.recordcount IS 0>
				<CFLOCATION URL="./netscrap.cfm">
			</CFIF>
---------------------------------->
<HTML>
	<HEAD>
		<!--  I'm really not a fan of the IE thing, but I dig this transition. My apologies.  -->
		<meta http-equiv="Page-Enter" content="revealTrans(Duration=3.0,Transition=23)">
		<meta http-equiv="Page-Exit" content="revealTrans(Duration=3.0,Transition=23)">
		<meta http-equiv="Site-Enter" content="revealTrans(Duration=3.0,Transition=23)">
		<meta http-equiv="Site-Exit" content="revealTrans(Duration=3.0,Transition=23)">
		<META HTTP-EQUIV="Refresh" CONTENT="8; URL=<CFOUTPUT>#url.url#</CFOUTPUT>">
		<META NAME="Author" CONTENT="Exit Page">
		<TITLE>NetScrap(TM) Exit Page</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" text="#000000" link="#5678AF" vlink="#888888" alink="#FF0000">

<CENTER>
	<table border=0 cellpadding=1 cellspacing=0 bgcolor="#000000" width=600><TR><TD>
		<CENTER>
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><td>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=#FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">Netscrap</A> &nbsp; : &nbsp; Exit Page &nbsp; : &nbsp;
				</FONT>
				</TD></TR>
			</TABLE>
		</CENTER>
	<table border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF" width=598><TR><TD>

			<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<IMG SRC="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>
	<P ALIGN=RIGHT>
	<FONT FACE="ARIAL BLACK" SIZE=5>
		 Exit Page
	</FONT>
	</P>

	<FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Don't be alarmed!</b>
	<P>
	Netscrap.com is just opening up another browser to look at this "other site's" page.
	Close this browser or hit ALT + TAB to return to NetScrap.com.
	<P>
	Come back soon!

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
