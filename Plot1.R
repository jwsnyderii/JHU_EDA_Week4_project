library(dplyr)

# Load in the data.  If the data is already in memory, skip operation
# to save time
if (!("NEI" %in% ls())) NEI <- readRDS("summarySCC_PM25.rds")
if (!("SCC" %in% ls())) SCC <- readRDS("Source_Classification_Code.rds")


# Get the total emissions (sum of all emissions) for each year 
totalE <- with(NEI, tapply(Emissions, year, sum))

# Creat a bar plot of total emmisions
# Scale to millions of tons (divide emissions by 1e6)
png(filename = "Plot1.png")
barplot(totalE/1e6, xlab = "Year", ylab = "PM2.5 Emissions (millions of tons)", 
        main = "Total PM2.5 Emissions in the USA ", col="red")
dev.off()
