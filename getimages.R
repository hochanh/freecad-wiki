library(httr)
library(XML)
f <- GET("http://www.freecadweb.org/wiki/api.php?action=query&list=allimages&ailimit=10&format=xml")

f.xml <- content(f, "text")
f.doc <- xmlInternalTreeParse(f.xml)
f.node <- getNodeSet(f.doc, "//allimages[@aicontinue]")
f.all <- ""
while (length(f.node) != 0) {
	# Get XML:
	f.cont <- xmlGetAttr(f.node[[1]],"aicontinue")
	f <- GET(paste0("http://www.freecadweb.org/wiki/api.php?action=query&list=allimages&ailimit=10&format=xml&aifrom=",f.cont))
	f.xml <- content(f, "text")
	f.doc <- xmlInternalTreeParse(f.xml)
	
	# Get image url:
	f.lst <- getNodeSet(f.doc, "//img")
	f.url <- xmlSApply(f.lst, function(x) xmlGetAttr(x,"url"))
	f.all <- paste0(f.all,"\n",str_c(f.url, collapse="\n"))
	
	# Get continue image
	f.node <- getNodeSet(f.doc, "//allimages[@aicontinue]")
}

writeLines(f.all,"img-list.txt")

# Next we use wget as
# wget -i ./img-list.txt -x