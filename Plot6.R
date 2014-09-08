## Exploratory Data Analysis project 2
##  Plot 6 Baltimore vs LA PM25 from vehicle sources
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## choose sources containing keyword "Vehicle" in EI.Sector (1138 sources)
vehicle_sources <- SCC[grepl("Vehicle",SCC[,4])==TRUE,1]

## choose only those rows out of Emissions dataset
totals<-aggregate(Emissions ~ year + fips, sum,
                  data=subset(NEI,SCC %in% vehicle_sources &
                                (fips == "24510" | fips == "06037")) )
## rename fips from code to Location name
totals[totals$fips=="24510",2] <-"Baltimore"
totals[totals$fips=="06037",2] <-"L.A. County"
# get the base values for the 2 sites
bt_start <-head(totals[totals$fips=="Baltimore",3],n=1)
la_start <-head(totals[totals$fips=="L.A. County",3],n=1)
# Compute Emissions as a percentage change from 1999 levels
totals[totals$fips=="Baltimore",4] <-
  totals[totals$fips=="Baltimore",3]/ bt_start * 100 - 100
totals[totals$fips=="L.A. County",4] <-
  totals[totals$fips=="L.A. County",3]/ la_start * 100 -100
colnames(totals)[4] <-"delta"

png(filename="plot6.png",width=480,height=480,units="px")

plot(totals$year[totals$fips=="Baltimore"],totals$delta[totals$fips=="Baltimore"],
     ylim=c(min(totals$delta),max(totals$delta)),col="red",
     ylab="vs 1999 Emissions(%)", xlab="year",
     main="Change in PM25 Emissions",type="b")
lines(totals$year[totals$fips=="L.A. County"],
      totals$delta[totals$fips=="L.A. County"],type="b",col="blue")
legend(x="right",legend=c("Baltimore","L.A. County"),col=c("red","blue"),lwd=1)
dev.off()
