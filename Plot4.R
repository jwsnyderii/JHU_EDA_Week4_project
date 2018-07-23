# Question 4: Across the United States, how have emissions from coal 
#             combustion-related sources changed from 1999–2008?
library(dplyr)

# Load in the data.  If the data is already in memory, skip operation
# to save time
if (!("NEI" %in% ls())) NEI <- readRDS("summarySCC_PM25.rds")
if (!("SCC" %in% ls())) SCC <- readRDS("Source_Classification_Code.rds")

# Find all SCC codes relate to coal combustion. I have decided to filter on all
# short names that include a "Comb" followed by "Coal".
SCC.coal.indices <- grep("comb.*coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC$SCC[SCC.coal.indices]

NEI.coal <- subset(NEI, SCC %in% SCC.coal)
total.coal <- as.vector(with(NEI.coal, tapply(Emissions, year, sum)))
mean.coal <- as.vector(with(NEI.coal, tapply(Emissions, year, mean)))
years <- levels(as.factor(NEI.coal$year))
observations <- (NEI.coal %>% group_by(year) %>% count)$n

# Creat a bar plot of total emmisions and mean PM2.5 measurement
# Scale to thousands of tons (divide emissions by 1e3)
# Both the total and the mean measurement of PM2.5 due to coal 
# combustion sources has decreased from 1999 to 2008
png(filename = "Plot4.png")
par(mfrow = c(2,1), mar=c(2,5,3,2))
barplot(total.coal/1e3, col= "red", 
        ylab = "Total PM2.5\n(thousands of tons)", 
        main = "PM2.5 from Coal Combustion\nin the USA")
par(mar=c(4,5,0,2))
barplot(mean.coal, names.arg = years, col= "blue", 
        ylab = "Mean PM2.5 (tons)", xlab = "Year")
dev.off()
