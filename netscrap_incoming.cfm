<CFSET DATASOURCE="netscrap">

<CFIF parameterExists(save_scrap) IS 1>
	INSERT Query Here...
        <CFQUERY NAME="EnterNewITEM" DATASOURCE="#DATASOURCE#">
                INSERT INTO netscrap_incoming
					(scrap_category, scrap_title, scrap_article, scrap_date, scrap_owner)
                VALUES
					('#Trim(scrap_category)#', '#Trim(scrap_title)#', '#scrap_article#', '#Trim(scrap_date)#', '#Trim(scrap_owner)#')
        </CFQUERY>
		<CFLOCATION URL="/netscrap_thanks.cfm?for=submit">
<CFELSE>
			<cfquery name="GetCategories" datasource="#DATASOURCE#">
				SELECT DISTINCT scrap_category
				FROM netscrap_articles
			</cfquery>

<HTML>
	<HEAD>
		<META NAME="Author" CONTENT="Netscrap Submit">
		<TITLE>NetScrap(TM) Submission</TITLE>
	</HEAD>

<BODY BGCOLOR="#DDDDDD" text="#000000" link="#5678AF" VLINK="#888888" alink="#FF0000">

<CENTER>
	<table border=0 cellpadding=1 cellspacing=0 bgcolor="#000000" width=600><TR><TD>
		<CENTER>
			<TABLE CELLPADDING=3 CELLSPACING=0>
				<TR><td>
				<FONT FACE="ARIAL,GENEVA" SIZE=1 COLOR=#FFFFFF>
					&nbsp; : &nbsp; <A HREF="./netscrap.cfm">NetScrap(TM)</A> &nbsp; : &nbsp; Submit &nbsp; : &nbsp; 
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
		<FONT FACE="ARIAL BLACK" SIZE=5>Submit to NetScrap(TM)</FONT>
		</P>

		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		There's no way in heck that a single group could collect and keep
		track of all the scrap floating arount the 'net. We need your help.
		Please take the time to look through the NetScrap(TM) archive to make
		sure we don't already have it <I>before you submit this</I>. 
		</FONT>
		</P>

		<P>
		<FONT FACE="ARIAL,GENEVA" SIZE=-1>
		Use the "Strip" feature to remove all those &gt;&gt;&gt; characters from your message if it's been passed around the net for a while. 
		</FONT>
		</P>


			<TABLE CELLPADDING=3 CELLSPACING=0 BORDER=0>
		
		<form action="/netscrap_incoming.cfm" method="POST" enctype="multipart/form-data" enablecab="Yes" name="netscrap_query_edit">
		<input type="Submit" name="edit_scrap" value="  StripArticle  "><input type="Submit" name="save_scrap" value="  Submit This Scrap  ">
			<TR VALIGN=TOP>
				<TD>
					<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Pick a Category:</B></FONT><BR>
					<select name="scrap_category">
					<OPTION VALUE="">Pick one</OPTION>
					<CFOUTPUT QUERY="GetCategories">
					<CFIF (#scrap_category# IS "SCAM") OR (#scrap_category# IS "TEMP")><CFELSE><OPTION VALUE="#trim(GetCategories.scrap_category)#" <CFIF #ParameterExists(form.scrap_category)#><CFIF #trim(form.scrap_category)# IS #trim(GetCategories.scrap_category)#>SELECTED</CFIF></CFIF>>#GetCategories.scrap_category#</OPTION></CFIF>
					</CFOUTPUT>
					</SELECT>
				</TD>
			</TR>
			<CFOUTPUT>
			<input type="Hidden" name="scrap_date" value="#DateFormat("#Now()#", "mm/dd/yyyy")#">
			<INPUT TYPE="hidden" Name="scrap_title_required" Value="You must enter a title">
			<INPUT TYPE="hidden" Name="scrap_category_required" Value="You must choose a category">
					<TR VALIGN=TOP>
						<TD>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Enter the Title: </B></FONT><BR>
							<INPUT TYPE="text" NAME="scrap_title" SIZE=46 VALUE="<CFIF #ParameterExists(form.scrap_title)# IS 1>#form.scrap_title#</CFIF>"></FONT>
						</TD>
					</TR>

					<TR VALIGN=TOP>
						<TD>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Strip out this pattern:</B></FONT><BR>
							<INPUT TYPE="text" NAME="edit_scrap" SIZE=10 VALUE=""><input type="Submit" name="edit_scrap" value="StripArticle">
						</TD>
					</TR>

					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Paste Your NetScrap(TM) Here:</B> Please delete the extra header information if this has been passed around the net a few times. </FONT><BR>
							<TEXTAREA NAME="scrap_article" ROWS=15 COLS=65 WRAP=PHYSICAL><CFIF #ParameterExists(form.scrap_article)# IS 1>#ReplaceList("#scrap_article#", "#form.edit_scrap#", "")#</CFIF></TEXTAREA></FONT>
						</TD>
					</TR>
					<TR VALIGN=TOP>
						<TD COLSPAN=2>
							<FONT FACE="ARIAL,HELVETICA" SIZE=-1><b>Who Owns This?</b> Include all Copyright information if possible.</FONT><BR>
							<TEXTAREA NAME="scrap_owner" ROWS=10 COLS=46 WRAP=PHYSICAL><CFIF #ParameterExists(form.scrap_owner)# IS 1>#scrap_owner#</CFIF></TEXTAREA>
						</TD>
					</TR>
					<TR VALIGN=TOP>
						<TD COLSPAN=2><input type="Submit" name="save_scrap" value="          Submit This Scrap          "></TD>
					</TR>
			</CFOUTPUT>
			</TABLE>
		
		</FORM>

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

</CFIF>