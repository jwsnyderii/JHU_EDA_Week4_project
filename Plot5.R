# Question 5: How have emissions from motor vehicle sources changed from 
#             1999–2008 in Baltimore City?
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


NEI.bc.Motor.total <- as.vector(with(NEI.bc.Motor, tapply(Emissions, year, sum)))
NEI.bc.Motor.mean <- as.vector(with(NEI.bc.Motor, tapply(Emissions, year, mean)))
years <- levels(as.factor(NEI.bc.Motor$year))
observations <- (NEI.bc.Motor %>% group_by(year) %>% count)$n

# Creat a bar plot of total emmisions
# Add a plot of mean PM2.5 measurements to show that the decrease is not 
# due to a decrease in the number of observations
png(filename = "Plot5.png")
par(mfrow = c(2,1), mar=c(2,5,3,2))
barplot(NEI.bc.Motor.total, col= "red", 
        ylab = "Total PM2.5(tons)", 
        main = "PM2.5 from Motor Vehicle Sources\nin Baltimore City")
par(mar=c(4,5,0,2))
barplot(NEI.bc.Motor.mean, names.arg = years, col= "blue", 
        ylab = "Mean PM2.5 (tons)", xlab = "Year")
dev.off()
