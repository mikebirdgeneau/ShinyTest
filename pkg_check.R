library(data.table)
dt.pkgs<-data.table(installed.packages())
dt.pkgs<-subset(dt.pkgs,select=c("Package","Version","LibPath","Built","NeedsCompilation","Depends","LinkingTo"))

dt.pkgs[Package=="Rcpp",]

dt.pkgs[,unlist(regmatches(Depends,m = regmatches(Depends,"Rcpp"))),by=c("Package","LibPath")]

.libPaths("/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

install.packages(unique(subset(dt.pkgs,Built!="3.1.2" & NeedsCompilation=="yes",select=c(Package,Version,Built))$Package))

#installed.packages()
