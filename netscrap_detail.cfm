<CFIF
	#CGI.HTTP_REFERER# IS NOT ""
	AND mid("#CGI.HTTP_REFERER#", 8, 8) IS NOT "netscrap"
	AND mid("#CGI.HTTP_REFERER#", 12, 8) IS NOT "netscrap"
	AND mid("#CGI.HTTP_REFERER#", 8, 6) IS NOT "gofish"
	AND #CGI.SERVER_NAME# IS NOT "localhost"><CFIF
		PARAMETEREXISTS(cookie.cookie_id_email)><CFSET
			email_id = cookie.cookie_id_email><CFELSE><CFSET
				email_id = "0"></CFIF><cffile
					action="APPEND"
					file="D:\FTP\chrisg2003\Htdocs\admin\netscrap_referer.log"
					output="%%#DateFormat(Now(), 'mm-dd-yy')#%%,%%/netscrap_detail.cfm?#CGI.QUERY_STRING#%%,%%#CGI.HTTP_REFERER#%%,%%#email_id#%%"><cferror
						type="REQUEST" template="./netscrap.cfm" mailto="scrapmaster@netscrap.com"></CFIF><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- error checking -->
<CFIF ParameterExists(scrap_id) IS 0>
	<CFLOCATION URL="/netscrap.cfm">
</CFIF>
<CFIF Isnumeric(scrap_id) IS "NO">
	<CFLOCATION URL="/netscrap.cfm">
</CFIF>
<CFQUERY name="get_scrap_detail" DATASOURCE="netscrap" cachedWithin = "#CreateTimeSpan(0, 6, 0, 0)#">
	SELECT     *, c.id, c.name
	FROM       netscrap_articles a, categories c
	WHERE      scrap_id = #url.scrap_id#
	AND 		a.categories_id = c.id
</CFQUERY>
<CFIF get_scrap_detail.recordcount IS 0>
	<CFLOCATION URL="/netscrap.cfm">
</CFIF>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<CFOUTPUT QUERY=get_scrap_detail>
	<head>
		<meta name="keywords" content="#scrap_keywords#">
		<meta name="author" content="Netscrap Section">
		<meta name="robots" content="index,nofollow">
		<title>NetScrap(TM): #scrap_title#</title>
		<script src="http://cdn.gigya.com/wildfire/js/wfapi.js"></script>
		<script type="text/javascript">digg_title = '#scrap_title#';</script>
		<script type="text/javascript">reddit_title='#urlencodedformat(scrap_title)#'</script>
		<script type="text/javascript">reddit_url='http://www.netscrap.com/netscrap_detail.cfm?scrap_id=#scrap_id#'</script>
		<script type="text/javascript" src="/js/jquery-latest.js" defer="defer"></script>
		<script type="text/javascript" src="/js/browser_detect.js" defer="defer"></script>
		<script type="text/javascript" src="/js/swfobject.js" defer="defer"></script>
		<script type="text/javascript" src="/js/vbs.js" defer="defer"></script>
	</head>
	</CFOUTPUT>

<body bgcolor="#dddddd" text="#000000" link="#5678af" vlink="#888888" alink="#ff0000">

<center>

<table border="0">
<tr>



 <td style="width:600px;text-align:left;">
 	<table border="0" cellpadding="1" cellspacing="0" bgcolor="#000000" width="600"><tr><td>
		<center>
			<CFOUTPUT QUERY="get_scrap_detail">
			<table cellpadding="3" cellspacing="0">
				<tr><td>
				<font face="arial, geneva" size="1" color="##ffffff">
					&nbsp; : &nbsp; <a href="./netscrap.cfm">Netscrap(TM)</a> &nbsp; : &nbsp; <a href="./netscrap.cfm?cat_show=#id#">#name#</a> &nbsp; : &nbsp; Netscrap ###scrap_id#  &nbsp; : &nbsp;
				</font>
				</td></tr>
			</table>
			</CFOUTPUT>
		</center>
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" width=598><tr><td>

		<map name="scrapnav">
         <area shape="RECT" coords="450,0,520,14" href="/netscrap_feedback.cfm">
         <area shape="RECT" coords="529,0,591,14" href="/netscrap_sitemap.cfm">
        </map>
	<img src="/images/netscrap_plain.jpg" width="600" usemap="#scrapnav" border="0">

	<table border="0" cellpadding=5 width="600"><tr><td>

<CFOUTPUT QUERY="get_scrap_detail">
	<p align="right">
	<font face="ARIAL BLACK" size="5">
		#scrap_title#
	</font>
	</p>

<pre style="text-align: left; text-decoration: none; color: black;">----- Begin NetScrap(TM) -----

#scrap_title#<br />

#scrap_article#<br />
<CFIF #scrap_url# IS NOT "">
<a href="/exit_url.cfm?url=#URLEncodedFormat(scrap_url)#" target="new">#scrap_url_description#</a>
</CFIF>
----- End NetScrap(TM) -----</pre>

<font face="arial, geneva" size="1">
	Entered on: #DateFormat(scrap_date, 'mm/dd/yyyy')#
</font>


<table border="0" cellpadding=7 cellspacing=0>
<tr>
	<td width="50%" bgcolor="##eeeeee"><font face="arial, geneva" size="-1"><b>Send it:</b></font></td>
	<td width="50%" bgcolor="##eeeeee">
		<font face="arial, geneva" size="-1">
		<CFIF get_scrap_detail.scrap_owner IS "">
			<font face="arial, geneva" size="-1"><b>Claim it:</b></font>
		<CFELSE>
			<font face="arial, geneva" size="-1"><b>Allegedly perpetrated by:</b></font>
		</CFIF>
		</font>
	</td>
</tr>
<tr valign="top">
	<td width="50%">
		<font face="arial, geneva" size="-1">
		Copy and paste this into an email to a  friend. We can make it easy for you. Mail
		it off with the <a href="./netscrap_mailtool.cfm?scrap_id=#url.scrap_id#">Netscrap(TM) MailTool</a>.
		</font>
	</td>
	<td width="50%">

		<CFIF get_scrap_detail.scrap_owner IS "">
		<font face="arial, geneva" size="-1">
			Did you do this? Do you own it? Can you prove it?
			Netscrap.com's mission is to reunite jokes like this with their
			creators.  <a href="netscrap_credit.cfm?scrap_id=#url.scrap_id#">Take credit for your fine work</a>.
		</font>
		<CFELSE>
		<font face="arial, geneva" size="-1">
			#get_scrap_detail.scrap_owner#
			<p>
		</font>
		<font face="arial, geneva" size="1">
			Got any more information about this? <a href="netscrap_credit.cfm?scrap_id=#url.scrap_id#">Add to the story</a>.
		</font>
		</CFIF>
	</td>
</tr>
</table>


<!-- Gigya Voodoo -->
<textarea id="postScrap" style="display: none">
 <table border="0" cellpadding=1 cellspacing="0" bgcolor="##000000" width="600"><tr><td align="center">
		<table cellpadding="3" cellspacing="0">
			<tr><td>
				<font face="arial, geneva" size="1" color="fff">
					&nbsp; : &nbsp; <a href="http://www.netscrap.com/netscrap.cfm">Netscrap(TM), Stuff and Things for You!</a> &nbsp; : &nbsp;
				</font>
			</td></tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0" bgcolor="##ffffff" width=598><tr><td>
			<map name="scrapnav">
				<area shape="RECT" coords="450,0,520,14" href="http://www.netscrap.com/netscrap_feedback.cfm">
				<area shape="RECT" coords="529,0,591,14" href="http://www.netscrap.com/netscrap_sitemap.cfm">
			</map>
			<img src="http://www.netscrap.com/images/netscrap_plain.jpg" width="600" usemap="##scrapnav" border="0">

			<table border="0" cellpadding="5" width="600"><tr><td>
				<p align="right"><font face="ARIAL BLACK" size="5">#scrap_title#</font></p>
				From <a href="http://www.netscrap.com">http://www.netscrap.com</a>:

<pre>----- Begin NetScrap(TM) -----

#scrap_title#<br />

#scrap_article#<br />
<CFIF #scrap_url# IS NOT "">
<a href="http://www.netscrap.com/exit_url.cfm?url=#URLEncodedFormat(scrap_url)#" target="new">#scrap_url_description#</a>
</CFIF>
----- End NetScrap(TM) -----</pre>

Lots more stuff and things for you at <a href="http://www.netscrap.com">http://www.netscrap.com</a>. Come and check it out!

<p><cfinclude template="./include_score.cfm"> </p>

	</td></tr></table>
</td></tr></table>
</textarea>

</CFOUTPUT>
<p><cfinclude template="./include_score.cfm"> </p>
<p><cfinclude template="./include_viral.cfm"> </p>


</font>
</td></tr></table>
<pre><font color="#ffffff">
---------------------------------------------------------------------------
75 Chars Wide</font></pre>

<cfinclude template="./netscrap_footer.cfm">
	</td></tr></table>
</td></tr></table>

<font face="arial, geneva" size="-1">We're testing ads. <a href="netscrap_feedback.cfm">Send feedback</a> if you have opinions about this. </font>

<CFIF ParameterExists(cookie.admin) IS "1">
	<CFIF cookie.admin IS "true">
		<CFOUTPUT><font face="arial, geneva" size="1"><a href="/admin/netscrap_edit_detail.cfm?scrap_id=#scrap_id#">Edit This</a> <a href="/admin/netscrap_delete_detail.cfm?scrap_id=#scrap_id#">Delete This</a></font></CFOUTPUT>
		<br clear=all />
		<cfoutput QUERY="get_scrap_detail">
		<iframe src="http://www.gofish.com/module/searchResults.gfp?keywords=#urlencodedformat(scrap_title)#+#urlencodedformat(scrap_keywords)#&sortby=date&count=3&view=thumbnail" title="Videos on gofish.com" frameborder="1" width="600" height="400"><!-- Alternate content for non-supporting browsers --><h2><a href="http://www.netscrap.com/score_results.cfm">Netscrap.com ROOLZ!!!!</a></h2></iframe>
		</cfoutput>

	</CFIF>
</CFIF>
<img src="http://technorati.com/faves?sub=addfavbtn&amp;add=http://greacen.com" height="1" width="1">

<cfinclude template="./include_ads.cfm">
 </td>

 <td style="width:300px;float:right;">
	Original music update daily:<br />
	<a href="http://songaday.netscrap.com/songs/?utm_source=http://www.netscrap.com"><img src="http://songaday.netscrap.com/songs/images/song-a-day-255.jpg" title="Listen to original music update daily" /></a>
	<br />Please visit our sponsor!


<script src="http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php" type="text/javascript"></script>
<fb:comments></fb:comments>
<script type="text/javascript">
    FB.init("2455e1ff50040915e66866d6e23e8c43", "/xd_receiver.htm");
</script>
 </td>

</tr>
</table>


</center>

<!-- start Vibrant Media IntelliTXT script section -->
<script type="text/javascript" src="http://netscrap.us.intellitxt.com/intellitxt/front.asp?ipid=10426"></script>
<!-- end Vibrant Media IntelliTXT script section -->
</body>
</html>
