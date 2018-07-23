# Question 3: Of the four types of sources indicated by the type (point, 
# nonpoint, onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
# increases in emissions from 1999–2008? Use the ggplot2 plotting system to 
# make a plot answer this question.
library(dplyr)
library(ggplot2)

# Load in the data.  If the data is already in memory, skip operation
# to save time
if (!("NEI" %in% ls())) NEI <- readRDS("summarySCC_PM25.rds")
if (!("SCC" %in% ls())) SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for Baltimore City
NEI.bc <- subset(NEI, fips == "24510" & !is.na(Emissions))

# Creat a bar plot of total emmisions
png(filename = "Plot3.png")
g <- ggplot(data = NEI.bc, mapping = aes(as.factor(year), Emissions))
g <- g + geom_col() + facet_grid(. ~ type) +
         ylab("Total PM2.5 (tons)") + xlab("Year") + 
         ggtitle("Emissions in Baltimore City by Source Type")
print(g)
dev.off()
