## Exploratory Data Analysis project 2
## requires ggplot2 package ( use install.packages("ggplot2") to install)
library("ggplot2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## compute sum by year and type
baltimore<-aggregate(Emissions ~ year+type , sum,
                     data=NEI[NEI$fips=="24510",])
##setup for png output
png(filename="plot3.png",width=480,height=480,units="px")
## plot Emissions vs year for each type
qplot(year,Emissions,data=baltimore,facets=type~.,geom=c("point","smooth"),method="lm",
      main="Baltimore City PM25",ylab="Emissions (tons)",xlab="Year")
dev.off()