# Question 6: Compare emissions from motor vehicle sources in Baltimore City 
#             with emissions from motor vehicle sources in Los Angeles County, 
#             California (fips == "06037"). Which city has seen greater changes
#             over time in motor vehicle emissions?
library(dplyr)

# Load in the data.  If the data is already in memory, skip operation
# to save time
if (!("NEI" %in% ls())) NEI <- readRDS("summarySCC_PM25.rds")
if (!("SCC" %in% ls())) SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for motor vehicle sources in Baltimore City.  I used the search term "Veh" to 
# find all motor vehicle sources in the SCC short names list.
SCC.motor.indices <- grep("Veh", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC$SCC[SCC.motor.indices]
NEI.bc.Motor <- subset(NEI, SCC %in% SCC.motor & fips == "24510")
NEI.la.Motor <- subset(NEI, SCC %in% SCC.motor & fips == "06037")


NEI.bc.Motor.total <- as.vector(with(NEI.bc.Motor, 
                                     tapply(Emissions, year, sum)))
NEI.la.Motor.total <- as.vector(with(NEI.la.Motor, 
                                     tapply(Emissions, year, sum)))
NEI.bc.Motor.mean <- as.vector(with(NEI.bc.Motor, 
                                    tapply(Emissions, year, mean)))
NEI.la.Motor.mean <- as.vector(with(NEI.la.Motor, 
                                    tapply(Emissions, year, mean)))
years <- levels(as.factor(NEI.bc.Motor$year))
obs.bc <- (NEI.bc.Motor %>% group_by(year) %>% count)$n
obs.la <- (NEI.la.Motor %>% group_by(year) %>% count)$n

# Creat a bar plot of total emmisions
# Add a plot of the mean emission measurement to demonstrate to show the large 
# increase in mean emissions in LA, due at least in part the low number of
# observation in LA county in 2008
png(filename = "Plot6.png")
par(mfrow = c(2,2), mar=c(1,5,3,0), oma = c(0,0,2,0))
barplot(NEI.bc.Motor.total, col= "red", 
        ylab = "Total PM2.5(tons)",
        main = "Baltimore City")
par(mar=c(1,3,3,1))
barplot(NEI.la.Motor.total, col= "red", 
        main = "LA County")
par(mar=c(4,5,0,0))
barplot(NEI.bc.Motor.mean, names.arg = years, col= "blue", 
        ylab = "Mean PM2.5 (tons)", xlab = "Year")
par(mar=c(4,3,0,1))
barplot(NEI.la.Motor.mean, names.arg = years, col= "blue", 
        xlab = "Year")
title("Emissions Due to Vehicle Sources", outer = TRUE)
dev.off()
