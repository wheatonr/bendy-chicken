## Exploratory Data Analysis project 2
## Plot 4- total PM25 from Coal Combustion 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## choose SCC values that contain the keywords "Comb" and "Coal" in thier Short.Name (91 results)
c3 <-SCC[grepl("Comb.*Coal",SCC[,3])==TRUE,1]

## choose SCC values that contain the keywords "Comb" and "Coal" in thier EI.Sector (99 results)
c4 <-SCC[grepl("Comb.*Coal",SCC[,4])==TRUE,1]

## so for completeness chose the union of the two

## choose only those rows out of Emissions dataset
totals<-aggregate(Emissions ~ year, sum,data=NEI[NEI$SCC %in% union(c3,c4),])

png(filename="plot4.png",width=480,height=480,units="px")
## plot Emissions vs year for each type
plot(totals$year,totals$Emissions/1e3,ylab="PM25 (Kilotons)",xlab="Year",
     main="Total PM25 Emissions from Coal Combustion",type="b")
dev.off()