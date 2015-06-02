ap <- available.packages()
if(file.exists("installed_packages.Rda")){
  load("installed_packages.Rda")
} else {
ip <- installed.packages()
}
pkgs.to.remove <- unique(as.character(ip[!(ip[,"Priority"] %in% c("base", "recommended")), 1]))
pkgs.to.remove<-pkgs.to.remove[which(!(pkgs.to.remove %in% "NexenOSPFM"))]
sapply(pkgs.to.remove, remove.packages)

library(tools)
deps <- package_dependencies("Rcpp",db=ap, which = c("Depends", "Imports", "LinkingTo"),reverse = TRUE,recursive=TRUE)$Rcpp
deps <- as.character(deps[which(deps %in% ip)])
pkgs.to.install <- pkgs.to.remove[which(!(pkgs.to.remove %in% deps))]

install.packages("http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.11.5.tar.gz",repos = NULL,type="source")
sapply(deps, install.packages, dependencies = FALSE)
sapply(pkgs.to.install, install.packages, dependencies = TRUE)

# Testing Final attempts
install.packages("http://cran.r-project.org/src/contrib/Archive/Rcpp/Rcpp_0.11.3.tar.gz",repos = NULL,type="source")
install.packages("http://cran.r-project.org/src/contrib/Archive/plyr/plyr_1.8.1.tar.gz",repos=NULL,type="source")
install.packages("http://cran.r-project.org/src/contrib/Archive/ggplot2/ggplot2_0.9.3.tar.gz",repos=NULL,type="source")
