<cfheader name="Content-type" value="text/plain">
<cfparam name="category" default="">
<cfif findnocase('netscrap',#cgi.server_name#)>
<cfparam name="organization" default="netscrap.com">
<cfelseif findnocase('greacen',#cgi.server_name#)>
<cfparam name="organization" default="greacenblog">
<cfelseif findnocase('isittheweekend',#cgi.server_name#)>
<cfparam name="organization" default="netscrap.com">
<cfelse>
<cfparam name="organization" default="netscrap.com">
</cfif>

<cfquery name="get_orgs" DATASOURCE="netscrap">
	select 	o.*
	from 	orgs o
	where 	o.name = '#organization#'
</cfquery><cfquery name="get_categories" DATASOURCE="netscrap">
	select 	c.*
	from 	orgs o, categories c
	where 	o.name = '#organization#'
	and 	c.orgs_id = o.id
	and 	c.visible = 1
</cfquery><cfquery name="get_scrap_detail" DATASOURCE="netscrap">
	select 	a.*, c.*, o.*
	from 	netscrap_articles a, categories c, orgs o
	where 	a.categories_id = c.id
	and 	c.orgs_id = o.id
	and		o.name = '#organization#'
	and 	c.visible = 1
	and		a.scrap_date < now()
	order 	by scrap_date DESC
</cfquery>

<cfif findnocase('netscrap',#cgi.server_name#)>
http://www.netscrap.com/netscrap_sitemap.cfm
http://www.netscrap.com/netscrap_tou.cfm
http://www.netscrap.com/netscrap_faq.cfm
http://www.netscrap.com/netscrap_feedback.cfm<cfoutput query="get_scrap_detail">
http://www.netscrap.com/netscrap_detail.cfm?scrap_id=#scrap_id#</cfoutput><cfoutput query="get_categories">
http://www.netscrap.com/netscrap.cfm?cat_show=#id#</cfoutput>
<cfelseif findnocase('photo.greacen',#cgi.server_name#)>
http://photo.greacen.com/
http://photo.greacen.com/greacen/photo/
<cfelseif findnocase('isittheweekend',#cgi.server_name#)>
http://isittheweekend.netscrap.com/
http://isittheweekend.netscrap.com/iitw/
<cfelseif findnocase('cranemountain',#cgi.server_name#)>
http://www.cranemountain.com/cm/
<cfelseif findnocase('greacen',#cgi.server_name#)>
http://greacen.com/greacen/?about=<cfoutput query="get_scrap_detail">
http://greacen.com/greacen/?post=#scrap_id#</cfoutput>
<cfelse>
</cfif>