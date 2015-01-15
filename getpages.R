library(stringr)
library(httr)
library(XML)
# Take a view at name space
ns <- GET("http://www.freecadweb.org/wiki/api.php?action=query&meta=siteinfo&siprop=namespaces")
content(ns)

# Get all pages in each namespace
for (i in 0:15) {
	api <- paste0("http://www.freecadweb.org/wiki/api.php?action=query&list=allpages&apfilterlanglinks=withoutlanglinks&aplimit=500&format=xml&apnamespace=",i)
	f <- GET(api)
	f.xml <- content(f, "text")
	f.doc <- xmlInternalTreeParse(f.xml)
	f.all <- ""
	repeat {
		# Get page title:
		f.lst <- getNodeSet(f.doc, "//p")
		f.url <- xmlSApply(f.lst, function(x) xmlGetAttr(x,"title"))
		f.all <- paste0(f.all,"\n",str_c(f.url, collapse="\n"))
		
		# Get continue image
		f.node <- getNodeSet(f.doc, "//allpages[@apcontinue]")
		if (length(f.node)==0) {break} else {
			f.cont <- xmlGetAttr(f.node[[1]],"apcontinue")
			f <- GET(paste0(api,"&apfrom=",f.cont))
			f.xml <- content(f, "text")
			f.doc <- xmlInternalTreeParse(f.xml)
		}
	}
	if (f.all != "\n") {
	path <- paste0("pages-ns-",i,".txt")
	writeLines(f.all,path)
	}
}
