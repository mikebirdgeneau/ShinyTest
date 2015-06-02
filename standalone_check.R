## NOTE: May need to 'source' this file to reproduce error. (running all lines independently may not generate the error.)

library(ggplot2)

set.seed(12345678)

sessionInfo()


littledata = data.frame(x=1:128, y=rlnorm(128))
bigdata = data.frame(x=1:129, y=rlnorm(129))


# plots as expected
lp = ggplot(littledata, aes(x,y))+geom_histogram(stat="identity", binwidth=1)

for (i in 1:20){
  print(i)
  try(suppressWarnings(print(lp+ggtitle(paste("128 points", i)))))
}

message("Done first!")

# always warns "position_stack requires constant width", 
# intermittently throws error, hangs, or segfaults.
# See below for details.
bp = ggplot(bigdata, aes(x,y))+geom_histogram(stat="identity", binwidth=1)

for(i in 1:30){
  print(i)
  try(suppressWarnings(print(bp+ggtitle(paste("129 points", i)))))
}
