ap <- available.packages()
if(file.exists("installed_packages.Rda")){
  load("installed_packages.Rda")
} else {
ip <- installed.packages()
}
pkgs.to.remove <- unique(as.character(ip[!(ip[,"Priority"] %in% c("base", "recommended")), 1]))
pkgs.to.remove<-pkgs.to.remove[which(!(pkgs.to.remove %in% "NexenOSPFM"))]
sapply(pkgs.to.remove, function(x){try(remove.packages(x))})

library(tools)
deps <- package_dependencies("Rcpp",db=ap, which = c("Depends", "Imports", "LinkingTo"),reverse = TRUE,recursive=TRUE)$Rcpp
deps <- as.character(deps[which(deps %in% ip)])
pkgs.to.install <- pkgs.to.remove[which(!(pkgs.to.remove %in% deps))]

install.packages("Rcpp")
sapply(deps, install.packages, dependencies = TRUE)
sapply(pkgs.to.install, install.packages, dependencies = TRUE)

library(tools)
library(devtools)
deps <- package_dependencies("Rcpp",db=installed.packages(), reverse = TRUE, recursive=TRUE)$Rcpp
deps <- deps[which(!(deps %in% c("NexenOSPFM")))]
install_version("Rcpp","0.11.5")
install.packages(deps,dependencies=FALSE)

deps <- package_dependencies("plyr",db=installed.packages(), reverse = TRUE, recursive=TRUE)$plyr
deps <- deps[which(!(deps %in% c("NexenOSPFM")))]
install.packages("http://cran.r-project.org/src/contrib/Archive/plyr/plyr_1.8.1.tar.gz",repos=NULL,dependencies=FALSE)
install.packages(deps,dependencies=FALSE)

install.packages(c("Rcpp","plyr","data.table","ggplot2","httpuv","shiny"))


install.packages("~/R/Local-Packages/NexenOSPFM_0.8.0_R_x86_64-unknown-linux-gnu.tar.gz",repos=FALSE,type="source")
