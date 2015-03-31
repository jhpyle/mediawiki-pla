# mediawiki-pla

This project is documentation of the MediaWiki configuration used by Philadelphia Legal Assistance.

# Installing MediaWiki

MediaWiki runs on PHP and MySQL.  See the [Installation Guide](http://www.mediawiki.org/wiki/Manual:Installation_guide) for instructions on installing it.

# Files in this project

## LocalSettings.php

This is the configuration file for the wiki.  On PLA's system, it is located in /var/lib/mediawiki-intake/.  This is the same folder with the primary index.php file for MediaWiki.

PLA actually has multiple wikis.  This LocalSettings.php file is for https://wiki.philalegal.org, but we also have wikis at http://eap.philalegal.org and http://pfp.philalegal.org.  You will see references to these wikis in the search engine configuration file, sphinx.conf.  Multiple wikis need to reside in different folders (with their own LocalSettings.php files), but they can share the same MySQL database by using different table prefixes.

## sphinx.conf

This is the configuration file for SphinxSearch, /etc/sphinxsearch/sphinx.conf.

SphinxSearch is a search engine.  We upgraded MediaWiki's default search engine to use SphinxSearch.  We had to install the sphinxsearch server:

    # apt-get install sphinxsearch

We also had to install and configure the SphinxSearch extension.  (See below for information about extensions.)

## wiki.philalegal.org.conf

This is the Apache configuration file, /etc/apache2/sites-available/wiki.philalegal.org.conf.  It points to the main wiki directory, /var/lib/mediawiki-intake/ where index.php gets launched and does the rest.

We have chosen to run our wiki on https so that passwords are encrypted.

## krb5.conf

This is the Kerberos configuration file, /etc/krb5.conf.  It points Apache to our Active Directory server.  See "LDAP authentication," below.

## mw-serve

This is the startup script for mw-serve, /etc/init.d/mw-serve.  This is necessary for obtaining high-quality PDF export to work on a non-public wiki.  See the Collection extension and the "PDF export with mw-serve" section below.

# Extensions

See [Extensions](http://www.mediawiki.org/wiki/Manual:Extensions) for instructions on how to install extensions.  Extensions are bundled as zip files or .tar.gz files and you unpack those files into the "extensions" subfolder.  Then you need to add something to LocalSettings.php to enable the extension.  Every extension has a page that explains what those lines need to say.

These are the extensions that PLA has installed.  Some of these come with MediaWiki; some may not actually be in use.

* **Babel** - for internationalization
* **Cite**
* **cldr**
* **CleanChanges**
* **CodeEditor**
* **Collection** - useful for being able to export multiple wiki pages in the format of a "book."  Requires setting up mw-serve; see below.
* **ConfirmEdit**
* **DynamicSidebar** - highly recommended - allows customization of the sidebar depending on the user's group.  with the LdapAuthentication extension, the group is determined from Active Directory.
* **EmbedVideo**
* **Flashlets**
* **FlvHandler**
* **Gadgets**
* **googleCalendar** - allows for embedding a public Google calendar
* **ImageMap**
* **InputBox**
* **Interwiki** - for being able to write links to other wikis (e.g., Wikipedia) with "internal" links like `[[Wikipedia:George Washington|our first president]]`.
* **jwplayer**
* **LabeledSectionTransclusion** - advanced feature - for being able to transclude 
* **LdapAuthentication** - excellent - connects with Active Directory
* **LocalisationUpdate**
* **Mantle**
* **MediawikiPlayer**
* **MobileFrontend** - this makes the site easier to use on smartphones
* **MsUpload** - a "must" - greatly simplifies the file upload process
* **Nuke**
* **ParserFunctions**
* **PdfExport**
* **PdfHandler**
* **Poem**
* **Renameuser**
* **Scribunto**
* **SemanticMediaWiki** - highly recommended - allows information from pages to be embedded in a linguistic way and queried programmatically
* **SpamBlacklist**
* **SphinxSearch** - we upgraded MediaWiki's default search engine to SphinxSearch
* **SyntaxHighlight_GeSHi**
* **TemplateData**
* **TitleBlacklist**
* **TitleKey** - highly recommended - makes page search queries case-insensitive.
* **Translate** - for internationalization
* **UniversalLanguageSelector**
* **UserMerge**
* **Validator**
* **Widgets**
* **WikiEditor**
* **YouTube** - for being able to embed YouTube videos with simple markup like `<youtube>hecXupPpE9o</youtube>`

# Installed Templates

Templates in MediaWiki are just regular MediaWiki pages that have names like "Template:The Simpsons".  When you insert `{{The Simpsons}}` in a page, MediaWiki replaces that text with the content of the template.  Templates may include other Templates and do various computational things.

You install Templates in the same way that you create pages -- by creating a page, typing in the WikiText, and saving.  If you have a collection of templates in an XML file that was created by Special:Export, you can import them using Special:Import, just as you can with ordinary pages.

After to create a template page, it will show you an error if the template you created requires a template that you have not yet installed.  So the process of satisfying template dependencies is not difficult, but it can be time-consuming.

The templates on PLA's wiki either came with MediaWiki or were created manually by me.  I found the templates on another site (e.g., Wikipedia's templates are publicly accessible just as its pages are), viewed the source, and copies and pasted the template source into pages on my own wiki.

The main templates that we use for navigation are [Template:Navbox](http://en.wikipedia.org/wiki/Template:Navbox) and [Template:Sidebar](http://en.wikipedia.org/wiki/Template:Sidebar).  These templates had a number of other templates as dependencies, and also depended on extensions being installed.

If any of the links below (to Wikipedia) do not work, you should just Google the name of the template and you might find it elsewhere.

* [Template:!](http://en.wikipedia.org/wiki/Template:!)
* [Template:-](http://en.wikipedia.org/wiki/Template:-)
* [Template:/doc](http://en.wikipedia.org/wiki/Template:/doc)
* [Template:1x](http://en.wikipedia.org/wiki/Template:1x)
* [Template:3x](http://en.wikipedia.org/wiki/Template:3x)
* [Template:Box portal skeleton/Categories](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Categories)
* [Template:Box portal skeleton/Did you know](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Did_you_know)
* [Template:Box portal skeleton/Intro](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Intro)
* [Template:Box portal skeleton/News](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/News)
* [Template:Box portal skeleton/Opentask](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Opentask)
* [Template:Box portal skeleton/Projects](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Projects)
* [Template:Box portal skeleton/Related portals](http://en.wikipedia.org/wiki/Template:Box_portal skeleton/Related portals)
* [Template:Box portal skeleton/Topics](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Topics)
* [Template:Box portal skeleton/Wikimedia](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/Wikimedia)
* [Template:Box portal skeleton/box-footer](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/box-footer)
* [Template:Box portal skeleton/box-header](http://en.wikipedia.org/wiki/Template:Box_portal_skeleton/box-header)
* [Template:Box-footer](http://en.wikipedia.org/wiki/Template:Box-footer)
* [Template:Box-header](http://en.wikipedia.org/wiki/Template:Box-header)
* [Template:Browsebar](http://en.wikipedia.org/wiki/Template:Browsebar)
* [Template:Code](http://en.wikipedia.org/wiki/Template:Code)
* [Template:Doc](http://en.wikipedia.org/wiki/Template:Doc)
* [Template:Documentation](http://en.wikipedia.org/wiki/Template:Documentation)
* [Template:Documentation subpage](http://en.wikipedia.org/wiki/Template:Documentation_subpage)
* [Template:Documentation/docspace](http://en.wikipedia.org/wiki/Template:Documentation/docspace)
* [Template:Documentation/end box](http://en.wikipedia.org/wiki/Template:Documentation/end_box)
* [Template:Documentation/end box2](http://en.wikipedia.org/wiki/Template:Documentation/end_box2)
* [Template:Documentation/start box](http://en.wikipedia.org/wiki/Template:Documentation/start_box)
* [Template:Documentation/start box2](http://en.wikipedia.org/wiki/Template:Documentation/start_box2)
* [Template:Documentation/template page](http://en.wikipedia.org/wiki/Template:Documentation/template_page)
* [Template:Esoteric](http://en.wikipedia.org/wiki/Template:Esoteric)
* [Template:Fmbox](http://en.wikipedia.org/wiki/Template:Fmbox)
* [Template:For loop](http://en.wikipedia.org/wiki/Template:For_loop)
* [Template:ForLoop/aux](http://en.wikipedia.org/wiki/Template:ForLoop/aux)
* [Template:High-risk](http://en.wikipedia.org/wiki/Template:High-risk)
* [Template:Icon](http://en.wikipedia.org/wiki/Template:Icon)
* [Template:Intricate template](http://en.wikipedia.org/wiki/Template:Intricate_template)
* [Template:Lorem ipsum](http://en.wikipedia.org/wiki/Template:Lorem_ipsum)
* [Template:Mbox](http://en.wikipedia.org/wiki/Template:Mbox)
* [Template:Mod](http://en.wikipedia.org/wiki/Template:Mod)
* [Template:Module rating](http://en.wikipedia.org/wiki/Template:Module_rating)
* [Template:Multicol](http://en.wikipedia.org/wiki/Template:Multicol)
* [Template:Multicol-break](http://en.wikipedia.org/wiki/Template:Multicol-break)
* [Template:Multicol-end](http://en.wikipedia.org/wiki/Template:Multicol-end)
* [Template:Namespace detect](http://en.wikipedia.org/wiki/Template:Namespace_detect)
* [Template:Navbar](http://en.wikipedia.org/wiki/Template:Navbar)
* [Template:Navbox](http://en.wikipedia.org/wiki/Template:Navbox)
* [Template:Navbox subgroup](http://en.wikipedia.org/wiki/Template:Navbox_subgroup)
* [Template:Navbox suite](http://en.wikipedia.org/wiki/Template:Navbox_suite)
* [Template:Navigation templates](http://en.wikipedia.org/wiki/Template:Navigation_templates)
* [Template:Nowrap](http://en.wikipedia.org/wiki/Template:Nowrap)
* [Template:Ombox](http://en.wikipedia.org/wiki/Template:Ombox)
* [Template:Ombox/core](http://en.wikipedia.org/wiki/Template:Ombox/core)
* [Template:Para](http://en.wikipedia.org/wiki/Template:Para)
* [Template:Portal](http://en.wikipedia.org/wiki/Template:Portal)
* [Template:Portal template list](http://en.wikipedia.org/wiki/Template:Portal_template_list)
* [Template:Portal/Images/Default](http://en.wikipedia.org/wiki/Template:Portal/Images/Default)
* [Template:Portal/Images/Science](http://en.wikipedia.org/wiki/Template:Portal/Images/Science)
* [Template:Portals](http://en.wikipedia.org/wiki/Template:Portals)
* [Template:Pp-book-cover](http://en.wikipedia.org/wiki/Template:Pp-book-cover)
* [Template:Pp-meta](http://en.wikipedia.org/wiki/Template:Pp-meta)
* [Template:Pp-template](http://en.wikipedia.org/wiki/Template:Pp-template)
* [Template:Purge](http://en.wikipedia.org/wiki/Template:Purge)
* [Template:Purge page](http://en.wikipedia.org/wiki/Template:Purge page)
* [Template:Purgepage](http://en.wikipedia.org/wiki/Template:Purgepage)
* [Template:Rand](http://en.wikipedia.org/wiki/Template:Rand)
* [Template:Random number](http://en.wikipedia.org/wiki/Template:Random_number)
* [Template:Random portal component with nominate](http://en.wikipedia.org/wiki/Template:Random_portal_component_with nominate)
* [Template:Refbegin](http://en.wikipedia.org/wiki/Template:Refbegin)
* [Template:Saved book](http://en.wikipedia.org/wiki/Template:Saved_book)
* [Template:Sidebar](http://en.wikipedia.org/wiki/Template:Sidebar)
* [Template:Strikethrough](http://en.wikipedia.org/wiki/Template:Strikethrough)
* [Template:Tbullet](http://en.wikipedia.org/wiki/Template:Tbullet)
* [Template:Template doc](http://en.wikipedia.org/wiki/Template:Template_doc)
* [Template:Template other](http://en.wikipedia.org/wiki/Template:Template_other)
* [Template:Template sandbox notice](http://en.wikipedia.org/wiki/Template:Template sandbox notice)
* [Template:TemplateDataHeader](http://en.wikipedia.org/wiki/Template:TemplateDataHeader)
* [Template:Tim](http://en.wikipedia.org/wiki/Template:Tim)
* [Template:Tiw](http://en.wikipedia.org/wiki/Template:Tiw)
* [Template:Tl](http://en.wikipedia.org/wiki/Template:Tl)
* [Template:Tlx](http://en.wikipedia.org/wiki/Template:Tlx)
* [Template:Transclude](http://en.wikipedia.org/wiki/Template:Transclude)
* [Template:Void](http://en.wikipedia.org/wiki/Template:Void)

# Notes about special features

## LDAP authentication

PLA uses a version of LDAP authentication that integrates with Apache.  Apache asks for the username and password, checks it against Active Directory using Kerberos, and then gives the username and password to MediaWiki, which runs an Active Directory to get the user's groups and other LDAP information.

The hardest part about setting this up was Kerberos.  I did a lot of things to get my Linux box to be able to query Active Directory, but I don't know which things were necessary.  I just followed some guides on the Internet.  Of course, because Microsoft is involved, the documentation was inscrutable and the process was painful.

## PDF export with mw-serve

High-quality PDF export is possible by installing and configuring [mw-serve](http://mwlib.readthedocs.org/en/latest/renderserver.html).  This was non-trivial.  It runs four daemon processes called "postman," "nslave," "nserve," and "mw-qserve."  Yes, this is needlessly complicated.  Moreover, the whole thing is currently broken because one of these daemons calls a library with deprecated code.

# Author

Jonathan Pyle, http://philalegal.org/jonathanpyle
