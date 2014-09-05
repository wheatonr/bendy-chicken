## Exploratory Data Analysis project 2

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## compute sum by year
totals<-aggregate(Emissions ~ year, sum,data=NEI)
##setup for png output
png(filename="plot1.png",width=480,height=480,units="px")

plot(totals$year,totals$Emissions/1e6,ylab="PM25 (Megatons)",xlab="Year",
     main="Total PM25 Emissions",type="b")
dev.off()