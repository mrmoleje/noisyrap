#read in data

install.packages("devtools")

noisyrap <- read.csv("./Data/bar_locations.csv", check.names=TRUE)

devtools::use_data(noisyrap)

rm(noisyrap)
