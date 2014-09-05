## Exploratory Data Analysis project 2
##  Plot 5 Baltimore PM25 from vehicle sources
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
## choose sources containing keyword "Vehicle" in EI.Sector (1138 sources)
vehicle_sources <- SCC[grepl("Vehicle",SCC[,4])==TRUE,1]

## choose only those rows out of Emissions dataset
totals<-aggregate(Emissions ~ year, sum,
                  data=subset(NEI,SCC %in% vehicle_sources & fips == "24510"))

png(filename="plot5.png",width=480,height=480,units="px")
## plot Emissions vs year for each type
plot(totals$year,totals$Emissions,ylab="PM25 (Tons)",xlab="Year",
     main="Baltimore PM25 Emissions from Vehicle sources",type="b")
dev.off()