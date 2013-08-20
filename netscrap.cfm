<CFIF #CGI.HTTP_REFERER# IS NOT "" AND mid("#CGI.HTTP_REFERER#", 8, 8) IS NOT "netscrap" AND mid("#CGI.HTTP_REFERER#", 12, 8) IS NOT "netscrap" AND #CGI.SERVER_NAME# IS NOT "localhost">
	<CFIF PARAMETEREXISTS(cookie.cookie_id_email)>
		<CFSET email_id = cookie.cookie_id_email>
	<CFELSE>
		<CFSET email_id = "0">
	</CFIF>
	<cffile action="APPEND" file="D:\FTP\chrisg2003\Htdocs\admin\netscrap_referer.log" output="%%#DateFormat(Now(), 'mm-dd-yy')#%%,%%/netscrap.cfm?#CGI.QUERY_STRING#%%,%%#CGI.HTTP_REFERER#%%,%%#email_id#%%">
	<cferror type="REQUEST" template="./netscrap.cfm" mailto="scrapmaster@netscrap.com">
</CFIF>
<cfquery name="get_categories" datasource="netscrap">
	SELECT     c.name, c.id
	FROM       orgs o, categories c
	WHERE      o.name = 'netscrap.com'
	AND		   o.id = c.orgs_id
	AND		   c.visible = true
</cfquery><html>
	<head>
		<meta name="description" content="NetScrap(TM) is the central repository for all the email jokes floating around the net. Our goal is to find the people who writes this stuff. ">
		<meta name="keywords" content="jokes,email,humor,funny,laugh,dirty jokes,good,fun,scrap,crap,netscrap,NetScrap(TM)">
		<meta name="Author" content="Netscrap Top Section">
		<meta name="robots" content="index,follow">
		<title>NetScrap.com: Stuff and Things for You!</title>
	</head>

<body bgcolor="#DDDDDD" text="#000000" link="#5678AF" VLINK="#888888" alink="#FF0000">
<center>
	<table border=0 cellpadding=1 cellspacing=0 bgcolor="#000000" width=600><tr><td>
	<center><font color="#FFFFFF">
			<cfoutput>
			<table cellpadding="3" cellspacing="0">
				<tr><td>
				<font face="ARIAL,GENEVA" size="1" color="##ffffff">
					&nbsp; : &nbsp; <CFIF PARAMETEREXISTS(url.cat_show)><a href="./netscrap.cfm"></CFIF>Netscrap(TM)</a> &nbsp; : &nbsp; <CFIF PARAMETEREXISTS(url.cat_show)>#cat_show#</a> &nbsp; : &nbsp; </CFIF>
				</font>
				</td></tr>
			</table>
			</cfoutput>
			</font></center>
	<table border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF" width=598><tr><TD WIDTH=600>
<CFIF PARAMETEREXISTS(CAT_SHOW) IS 1>
  <CFIF isnumeric(CAT_SHOW) IS 1>
	<CFQUERY NAME="get_category" DATASOURCE="netscrap">
		SELECT    a.scrap_id, a.scrap_title, a.scrap_date, a.scrap_rating, c.name as cat
		FROM      netscrap_articles a, categories c
		WHERE     c.id= #url.cat_show#
		AND 	  c.id = a.categories_id
		<CFIF Parameterexists(sort) IS 1>
			<CFIF sort is "title">
				ORDER BY scrap_title
			<CFELSEIF sort is "rating">
				ORDER BY scrap_rating
			<CFELSEIF sort is "date">
				ORDER BY scrap_date
			</CFIF>
		<CFELSE>
			ORDER BY scrap_title
		</CFIF>
	</CFQUERY>
	<cfelse>
		<CFQUERY NAME="get_category" DATASOURCE="netscrap">
			SELECT    a.scrap_id, a.scrap_category as cat, a.scrap_title, a.scrap_date, a.scrap_rating, c.name as title
			FROM      netscrap_articles a, categories c
			WHERE     c.name= '#url.cat_show#'
			AND 	  c.id = a.categories_id
			<CFIF Parameterexists(sort) IS 1>
				<CFIF sort is "title">
					ORDER BY scrap_title
				<CFELSEIF sort is "rating">
					ORDER BY scrap_rating
				<CFELSEIF sort is "date">
					ORDER BY scrap_date
				</CFIF>
			<CFELSE>
				ORDER BY scrap_title
			</CFIF>
	    </CFQUERY>
    </cfif>
	<CFIF get_category.recordcount LT 1>
		<CFLOCATION URL="./netscrap.cfm">
	</CFIF>
		<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<img src="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>
	<table border="0" cellpadding="5" width="600"><tr><td>
	<cfoutput>
		<P align="right">
		<font face="ARIAL BLACK" size="5">#get_category.cat#</font>
		</P>
		<table border="0" cellpadding="4" cellspacing="0" width="100%">
				<tr>
					<td align="center" bgcolor="##eeeeee"><font face="ARIAL,GENEVA" SIZE=-1>NetScrap ##:</font></td>
					<td bgcolor="##eeeeee"><font face="ARIAL,GENEVA" SIZE=-1><a href="./netscrap.cfm?cat_show=#URLEncodedFormat(url.cat_show)#&sort=title"><b>Title</b></a></font></td>
					<td align="center" bgcolor="##eeeeee"><font face="ARIAL,GENEVA" SIZE=-1><a href="./netscrap.cfm?cat_show=#URLEncodedFormat(url.cat_show)#&sort=rating"><b>Rating</b></a></font></td>
					<td align="center" bgcolor="##eeeeee"><font face="ARIAL,GENEVA" SIZE=-1><a href="./netscrap.cfm?cat_show=#URLEncodedFormat(url.cat_show)#&sort=date"><b>Date</b></a></font></td>
				</tr>
	</cfoutput>
		<CFOUTPUT QUERY="get_category">
			<tr valign="TOP">
				<td align="center"><font face="ARIAL,GENEVA" SIZE=-1>#scrap_id#</font></td>
				<td><font face="ARIAL,GENEVA" SIZE=-1><a href="./netscrap_detail.cfm?scrap_id=#scrap_id#">#scrap_title#</a></font></td>
				<td align="center"><font face="ARIAL,GENEVA" size="1"><b><CFIF #scrap_rating# IS 5>PG<CFELSE>PG-13</CFIF></font></b></td>
				<td align="center"><font face="ARIAL,GENEVA" SIZE=-1>#DateFormat(scrap_date, 'mm/dd/yy')#</font></td>
			</tr>
		</cfoutput>
	</table>

	</td></tr></table>

<CFELSE>
		<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<img src="/images/netscrap4.jpg" width="600" border="0" usemap="#scrapnav">
	<table border="0" cellpadding="5" width="600"><tr><td>
	<font face="ARIAL,GENEVA" size="-1">
		Netscrap <b>is</b> the place with the stuff! We don't have much scrap here right now, but
		we think you'll be able to see the direction we're headed. Take a look around and let
		us know what you think. We have about <b>800</b> scraps and more messages queued up to be categorized.
		If you want to help us work with this stuff, do a little editing drop a line.
		We'd love to hear from you.
	</font>
	<CFSET switch = Int(get_categories.recordcount/4)>
	<CFSET switch2 = switch -1 >
	<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr valign="top"><td colspan="6"><font face="ARIAL,GENEVA"><b>&nbsp;</b></font></td></tr>

	<tr valign="top"><td colspan="6"><font face="ARIAL,GENEVA"><b>Search by Category.</b></font></td></tr>
	<tr valign="top"><td colspan="1" WIDTH="100">
		<CFOUTPUT QUERY="get_categories">
		<!--- For Debug: #switch#, #switch2# --->
		<font face="ARIAL,GENEVA" SIZE=-1><a href="./netscrap.cfm?cat_show=#id#">#name#</a></font><BR>
		<CFIF #currentrow# GT #switch2#>
			</td><td>
			<CFSET switch2 = switch + currentrow -1>
		</CFIF>
		</cfoutput>
	</td></tr>
</table>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr valign="top"><td colspan="6"><font face="ARIAL,GENEVA"><b>&nbsp;</b></font></td><td></td></tr>
	<tr valign="top"><td colspan="6"><font face="ARIAL,GENEVA"><b>Browse by Popular Scrap.</b></font><br>
	<font face="ARIAL,GENEVA" SIZE=-1><a href="./score_results.cfm">Top Ten Messages this week!</a></font><br>
	<font face="ARIAL,GENEVA" SIZE=-1><a href="./netscrap_video.cfm">Watch Videos!</a></font>

	</td>
			<td align="right" rowspan=9>
			<!-- Altering or removing this link is a breach of the Vizu Terms and Conditions -->
			<div style="font-family:Arial, Helvetica, sans-serif; font-size:10px;height:20px;text-align:center;width:230px;margin:0;padding:0;"><a
			href="http://www.vizu.com" target="_blank"><span style="color:#999;text-decoration:underline;font-size:10px;">Opinion
			Polls</span></a><span style="color:#999;">&nbsp;&amp;&nbsp;</span><a href="http://answers.vizu.com/market-research.htm" target="_blank"><span
			style="color:#999;text-decoration:underline;font-size:10px;">Market Research</span></a></div><embed
			src="http://wp.vizu.com/vizu_poll.swf" quality="high" scale="noscale" wmode="transparent" bgcolor="#ffffff"
			width="230" height="484" name="vizu_poll" align="middle" allowScriptAccess="always"
			type="application/x-shockwave-flash"
			FlashVars="js=false&pid=67517&ad=false&vizu=true&links=true&mainBG=ffffff&questionText=000000&answerZoneBG=cccccc&answerItemBG=eeeeee&answerText=000000&voteBG=999999&voteText=000000"></embed>
			</td>
	</tr>
	<tr valign="top"><td colspan="6"><font face="ARIAL,GENEVA"><b>Search the Archive.</b></font><br>
			<font face="ARIAL,GENEVA" SIZE=-1>
				<form action="./netscrap_search.cfm" method="POST" enctype="multipart/form-data">
				<input type="Text" name="criteria" value="Enter Search Terms Here" size="30" maxlength="30">
				<input type="Submit" name="Netscrap_Search" value="Search">
				</form>
			</font>
		</td>
	</tr>
	<tr valign="top"><td colspan="6"><font face="ARIAL,GENEVA"><b>Submit!</b></font><br />
	<font face="ARIAL,GENEVA" SIZE=-1>Found something you feel is worthy of sharing? <a href="./netscrap_incoming.cfm">Send me your NetScrap</a>!</font></td></tr>
	</table>

	</td></tr></table>
</CFIF>




<font color=#FFFFFF SIZE=3>
<PRE>---------------------------------------------------------------------------
75 Chars Wide</PRE></font>
<cfinclude template="./netscrap_footer.cfm">
	</td></tr></table>
</td></tr></table>
<cfinclude template="./include_ads.cfm">

</center>
</BODY>
</HTML>
