library(stringr)
query <- readLines("query.txt")
query <- str_c(query, collapse="\n")
title <- str_match_all(query,"title=\"[[:alnum:]|[:blank:]]+\"")
title <- as.data.frame(title, stringsAsFactors=F)
list <- rep("",851)
for (i in 1:851){
  list[i] <- title[i,1]
}
list <- str_replace_all(list,"title=\"([[:alnum:]|[:blank:]]+)\"","\\1")
writeLines(list,"list.txt")