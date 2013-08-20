		<CFIF #CGI.HTTP_REFERER# IS NOT "" AND mid("#CGI.HTTP_REFERER#", 8, 8) IS NOT "netscrap" AND mid("#CGI.HTTP_REFERER#", 12, 8) IS NOT "netscrap">
			<CFIF PARAMETEREXISTS(cookie.cookie_id_email)>
				<CFSET email_id = cookie.cookie_id_email>
			<CFELSE>
				<CFSET email_id = "0">
			</CFIF>
			<cffile action="APPEND" file="D:\FTP\chrisg\Htdocs\admin\netscrap_referer.log" output="%%#DateFormat(Now(), 'mm-dd-yy')#%%,%%/netscrap_detail.cfm?#CGI.QUERY_STRING#%%,%%#CGI.HTTP_REFERER#%%,%%#email_id#%%">
			<cferror type="REQUEST" template="./netscrap.cfm" mailto="scrapmaster@netscrap.com">
		</CFIF>
<CFIF ParameterExists(scrap_id) IS 0>
	<CFLOCATION URL="/netscrap.cfm">
</CFIF>
<CFIF Isnumeric(scrap_id) IS "NO">
	<CFLOCATION URL="/netscrap.cfm">
</CFIF>
<CFQUERY NAME="get_scrap_detail" DATASOURCE="netscrap">
	SELECT     *
	FROM       netscrap_articles
	WHERE      scrap_id = #url.scrap_id#
</CFQUERY>
<CFIF get_scrap_detail.recordcount IS 0>
	<CFLOCATION URL="/netscrap.cfm">
</CFIF>
<HTML>
	<CFOUTPUT QUERY=get_scrap_detail>
	<HEAD>
		<META NAME="KEYWORDS" CONTENT="#scrap_keywords#">
		<META NAME="Author" CONTENT="Netscrap Section">
		<meta name="robots" content="index,nofollow">
		<TITLE>NetScrap(TM): #scrap_title#</TITLE>
	</HEAD>
	</CFOUTPUT>

<BODY BGCOLOR="#DDDDDD" text="#000000" link="#5678AF" VLINK="#888888" alink="#FF0000">

<CENTER>
	<table border=0 cellpadding=1 cellspacing=0 bgcolor="#000000" width=600><TR><TD>
		<CENTER>
			<CFOUTPUT QUERY="get_scrap_detail">
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><td>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=##FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">Netscrap(TM)</A> &nbsp; : &nbsp; <A HREF="./netscrap.cfm?cat_show=#URLEncodedFormat(scrap_category)#">#scrap_category#</A> &nbsp; : &nbsp; Netscrap ###scrap_id#  &nbsp; : &nbsp;
				</FONT>
				</TD></TR>
			</TABLE>
			</CFOUTPUT>
		</CENTER>
	<table border=0 cellpadding=0 cellspacing=0 bgcolor="#FFFFFF" width=598><TR><TD>

			<MAP NAME="scrapnav">
        <AREA SHAPE="RECT" COORDS="450,0,520,14" HREF="/netscrap_feedback.cfm">
        <AREA SHAPE="RECT" COORDS="529,0,591,14" HREF="/netscrap_sitemap.cfm">
        </MAP>
	<IMG SRC="/images/netscrap_plain.jpg" WIDTH=600 USEMAP="#scrapnav" BORDER=0>

	<TABLE BORDER=0 CELLPADDING=5 WIDTH=600><TR><TD>

<CFOUTPUT QUERY="get_scrap_detail">


	<P ALIGN=RIGHT>
	<FONT FACE="ARIAL BLACK" SIZE=5>
		#scrap_title#
	</FONT>
	</P>
<PRE>----- Begin NetScrap(TM) -----

#scrap_title#<BR>

#scrap_article#<BR>
<CFIF #scrap_url# IS NOT "">
<A HREF="/exit_url.cfm?url=#URLEncodedFormat(scrap_url)#" TARGET=NEW>#scrap_url_description#</A>
</CFIF>
----- End NetScrap(TM) -----</PRE>
<FONT FACE="ARIAL,GENEVA" SIZE=1>
	Entered on: #DateFormat(scrap_date, 'mm/dd/yyyy')#
</FONT>


IFRAME
<table border=0 cellpadding=7 cellspacing=0>
	<tr>
		<td width=100% bgcolor=##FFFFFF>
			<font face="ARIAL,GENEVA" size="-1">
<!---
<iframe src="" title="Netscrap.com" frameborder="0" width="650" height="225"><!-- Alternate content for non-supporting browsers --><h2><a href="">Netscrap.com ROOLZ!!!!</a></h2></iframe>
&lt;iframe src=&quot;&quot; title=&quot;Netscrap.com&quot; frameborder=&quot;0&quot; width=&quot;650&quot; height=&quot;225&quot;&gt;&lt;!-- Alternate content for non-supporting browsers --&gt;&lt;h2&gt;&lt;a href=&quot;&quot;&gt;Netscrap.com ROOLZ!!!!&lt;/a&gt;&lt;/h2&gt;&lt;/iframe&gt;
--->
<center>
Add this scrap to your myspace page!
<form name="scrapForm" id="scrapForm">
<input name="scrap_embed" type="text" value="&lt;iframe src=&quot;http://www.netscrap.com/test_netscrap_detail.cfm?scrap_id=#scrap_id#&quot; title=&quot;Netscrap.com&quot; frameborder=&quot;0&quot; width=&quot;650&quot; height=&quot;225&quot;&gt;&lt;!-- Alternate content for non-supporting browsers --&gt;&lt;h2&gt;&lt;a href=&quot;http://www.netscrap.com/test_netscrap_detail.cfm?scrap_id=#scrap_id#&quot;&gt;Netscrap.com ROOLZ!!!!&lt;/a&gt;&lt;/h2&gt;&lt;/iframe&gt;"  onclick="javascript:document.scrapForm.scrap_embed.focus();document.scrapForm.scrap_embed.select();" readonly="true">
</form>
</center>

			</font>
		</td>
	</tr>
</table>


OBJECT
<table border=0 cellpadding=7 cellspacing=0>
	<tr>
		<td width=100% bgcolor=##FFFFFF>
			<font face="ARIAL,GENEVA" size="-1">
<!---
<object data="http://www.netscrap.com/netscrap_detail.cfm?scrap_id=856" type="text/html" width=650 height=225 border=1 hspace=0 vspace=0></object>
&lt;object data=&quot;http://www.netscrap.com/netscrap_detail.cfm?scrap_id=856&quot; type=&quot;text/html&quot; width=&quot;650&quot; height=&quot;225&quot; border=&quot;1&quot; hspace=&quot;0&quot; vspace=&quot;0&quot;&gt;&lt;/object&gt;
--->
<center>
Add this scrap to your myspace page!
<form name="scrapForm" id="scrapForm">
<input name="scrap_embed" type="text" value="&lt;object data=&quot;http://www.netscrap.com/netscrap_detail.cfm?scrap_id=856&quot; type=&quot;text/html&quot; width=&quot;650&quot; height=&quot;225&quot; border=&quot;1&quot; hspace=&quot;0&quot; vspace=&quot;0&quot;&gt;&lt;/object&gt;"  onclick="javascript:document.scrapForm.scrap_embed.focus();document.scrapForm.scrap_embed.select();" readonly="true">
</form>
</center>

			</font>
		</td>
	</tr>
</table>


<TABLE BORDER=0 CELLPADDING=7 CELLSPACING=0>
<TR>
	<TD WIDTH=50% BGCOLOR=##EEEEEE><FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Send it:</b></FONT></TD>
	<TD WIDTH=50% BGCOLOR=##EEEEEE>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		<CFIF get_scrap_detail.scrap_owner IS "">
			<FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Claim it:</b></FONT>
		<CFELSE>
			<FONT FACE="ARIAL,GENEVA" SIZE=-1><b>Allegedly perpetrated by:</b></FONT>
		</CFIF>
		</FONT>
	</TD>
</TR>
<TR VALIGN=TOP>
	<TD WIDTH=50%>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		Copy and paste this into an email to a  friend. We can make it easy for you. Mail
		it off with the <A HREF="./netscrap_mailtool.cfm?scrap_id=#url.scrap_id#">Netscrap(TM) MailTool</A>.
		</FONT>
	</TD>
	<TD WIDTH=50%>

		<CFIF get_scrap_detail.scrap_owner IS "">
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			Did you do this? Do you own it? Can you prove it?
			Netscrap.com's mission is to reunite jokes like this with their
			creators.  <A HREF="netscrap_credit.cfm?scrap_id=#url.scrap_id#">Take credit for your fine work</A>.
		</FONT>
		<CFELSE>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
			#get_scrap_detail.scrap_owner#
			<P>
		</FONT>
		<FONT FACE="ARIAL,GENEVA" SIZE=1>
			Got any more information about this? <A HREF="netscrap_credit.cfm?scrap_id=#url.scrap_id#">Add to the story</A>.
		</FONT>
		</CFIF>
	</TD>
</TR>
</TABLE>
</CFOUTPUT>
<P>
		<cfinclude template="./include_score.cfm">
</FONT>
</TD></TR></TABLE>
<PRE><FONT COLOR=#FFFFFF>
---------------------------------------------------------------------------
75 Chars Wide</FONT></PRE>
<cfinclude template="./netscrap_footer.cfm">
	</TD></TR></TABLE>
</TD></TR></TABLE>
<FONT FACE="ARIAL,GENEVA" SIZE=-1>We're testing ads. <a href="netscrap_feedback.cfm">Send feedback</a> if you have opinions about this. </FONT>

<CFIF ParameterExists(cookie.admin) IS "1">
	<CFIF cookie.admin IS "true">
		<CFOUTPUT><FONT FACE="ARIAL,GENEVA" SIZE=1><A HREF="/admin/netscrap_edit_detail.cfm?scrap_id=#scrap_id#">Edit This</A> <A HREF="/admin/netscrap_delete_detail.cfm?scrap_id=#scrap_id#">Delete This</A></FONT></CFOUTPUT>
	</CFIF>
</CFIF>


<br clear=all />

<script type="text/javascript"><!--
google_ad_client = "pub-8550799684094358";
google_ad_width = 300;
google_ad_height = 250;
google_ad_format = "300x250_as";
google_ad_type = "text_image";
google_ad_channel ="5484571443";
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
google_ad_channel ="5484571443";
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
