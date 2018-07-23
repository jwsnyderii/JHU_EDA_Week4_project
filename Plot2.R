library(dplyr)

# Load in the data.  If the data is already in memory, skip operation
# to save time
if (!("NEI" %in% ls())) NEI <- readRDS("summarySCC_PM25.rds")
if (!("SCC" %in% ls())) SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for Baltimore City
NEI.bc <- subset(NEI, fips == "24510")

# Get the total emissions (sum of all emissions) for each year
totalE.bc <- with(NEI.bc, tapply(Emissions, year, sum))

# Creat a bar plot of total emmisions
png(filename = "Plot2.png")
barplot(totalE.bc, xlab = "Year", ylab = "PM2.5 Emissions(tons)", 
        main = "Total PM2.5 Emissions in Baltimore City", col="red")
dev.off()
