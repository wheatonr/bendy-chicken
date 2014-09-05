## Exploratory Data Analysis project 2

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## compute sum by year
baltimore<-aggregate(Emissions ~ year, sum,data=NEI[NEI$fips=="24510",])
##setup for png output
png(filename="plot2.png",width=480,height=480,units="px")

plot(baltimore,type="p",main="Baltimore City PM25 Emissions",
     ylab="PM25 (tons)",xlab="Year")
abline(lm(Emissions ~ year,baltimore),col="red")

legend(x="bottomleft",legend=c("observed","trend"),col=c("black","red"),
       lwd=1,lty=c(NA,1),pch=c(1,NA))
dev.off()