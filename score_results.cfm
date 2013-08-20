<CFIF PARAMETEREXISTS(url.scrap_id)>
	<CFQUERY NAME="check_fraud" DATASOURCE="netscrap">
		SELECT	*
		FROM	score2
		WHERE	user_ip = '#cgi.REMOTE_ADDR#'
		AND		scrap_id = #url.scrap_id#
	</CFQUERY>


	<CFIF check_fraud.recordcount GTE 1>
		<CFSET fraud = "ohyeah">
	<CFELSE>
		<CFSET fraud = "notreally">
		<CFQUERY NAME="record_vote" DATASOURCE="netscrap">
			INSERT INTO score2
				(scrap_id, vote, user_ip)
			VALUES
				('#url.scrap_id#', '#score#', '#cgi.REMOTE_ADDR#')

		</CFQUERY>
	</CFIF>
<CFELSE>
	<CFSET fraud = "justbrowsing">
</CFIF>

<CFQUERY NAME="top_ten" DATASOURCE="netscrap">
	SELECT score2.scrap_id, Avg(score2.vote) AS vote_average, count(score2.vote) AS vote_count,
	(SELECT netscrap_articles.scrap_title FROM netscrap_articles WHERE netscrap_articles.scrap_id = score2.scrap_id) AS scrap_title
	FROM score2
	GROUP BY score2.scrap_id
	ORDER BY Avg(score2.vote) DESC
</CFQUERY>




<HTML>
	<HEAD>
		<META NAME="Author" CONTENT="Top 10 NetScrap(TM) Articles">
		<TITLE>Top 10 NetScrap(TM) Articles</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" text="#000000" link="#5678AF" vlink="#888888" alink="#FF0000">

<CENTER>
	<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=0 BGCOLOR="#000000" WIDTH=600><TR><TD>
		<CENTER>
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><TD>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=#FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">NetScrap(TM)</A> &nbsp; : &nbsp; Top 10 &nbsp; : &nbsp;
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
		<FONT FACE="ARIAL BLACK" SIZE=5>
		Top 10 NetScrap(TM) Articles
		</FONT>
		</P>




<FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Here are the top 10: </b></FONT>

<CFIF fraud IS "notreally">
	<FONT FACE="ARIAL,GENEVA" SIZE=-1><B>
		Thanks for voting!
	</B></FONT>
	<BR>
<CFELSEIF fraud IS "ohyeah">
	<FONT FACE="ARIAL,GENEVA" SIZE=-1><B>
		You already voted, punk.
	</B></FONT>
	<P>
	<FONT FACE="ARIAL,GENEVA" SIZE=-1>Voter Fraud is legal only in certain areas.</FONT>
	<BR>
</CFIF>
<P>

<TABLE CELLPADDING=4 CELLSPACING=0 WIDTH=100%>
<TR VALIGN=TOP>
	<TD BGCOLOR="#EEEEEE"><FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Article</b></FONT><P></TD>
	<TD ALIGN=CENTER BGCOLOR="#EEEEEE"><FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Current Score</b></FONT></TD>
	<TD ALIGN=CENTER BGCOLOR="#EEEEEE"><FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Total Votes</b></FONT></TD>
</TR>
<cfoutput query="top_ten" startrow=1 maxrows=10>
	<TR VALIGN=TOP>
		<TD><FONT FACE="ARIAL,GENEVA" SIZE=-1><A HREF="./netscrap_detail.cfm?scrap_id=#scrap_id#">#scrap_title#</A></FONT></TD>
		<TD ALIGN=CENTER><FONT FACE="ARIAL,GENEVA" SIZE=-1>#NumberFormat(vote_average, '__.___')#</FONT></TD>
		<TD ALIGN=CENTER><FONT FACE="ARIAL,GENEVA" SIZE=-1>#vote_count#</FONT></TD>
	</TR>
</CFOUTPUT>
</TABLE>

</TD></TR></TABLE>


<FONT COLOR=WHITE>
<PRE>---------------------------------------------------------------------------
75 Chars Wide</PRE>
</FONT>
<cfinclude template="./netscrap_footer.cfm">
	</TD></TR></TABLE>
</TD></TR></TABLE>


<br clear=all>
<script type="text/javascript"><!--
google_ad_client = "pub-8550799684094358";
google_ad_width = 300;
google_ad_height = 250;
google_ad_format = "300x250_as";
google_ad_type = "text_image";
google_ad_channel ="9731313632";
google_color_border = "000000";
google_color_bg = "FFFFFF";
google_color_link = "003366";
google_color_text = "000000";
google_color_url = "6C82B5";
//--></script>
<script type="text/javascript"
  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>

<script type="text/javascript"><!--
google_ad_client = "pub-8550799684094358";
google_ad_width = 300;
google_ad_height = 250;
google_ad_format = "300x250_as";
google_ad_type = "image";
google_ad_channel ="9731313632";
google_color_border = "000000";
google_color_bg = "FFFFFF";
google_color_link = "003366";
google_color_text = "000000";
google_color_url = "6C82B5";
//--></script>
<script type="text/javascript"
  src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>

</CENTER>
</BODY>
</HTML>
