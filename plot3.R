
#################################### Exploratory Data Analysis ##########################################

# Week 4: Assignment 2

# Question 3: 
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#****************************** Preparations *************************************************************

# Clean up workspace
rm(list=ls())

library(ggplot2)

#****************************** Read data *************************************************************

# Read the unzipped files:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter data from Baltimore City, Maryland 
NEI_Baltimore <- subset(NEI, fips == "24510")

# Get total emissions per year per type for Baltimore. The next one works just fine:
# aggEmission <- aggregate(NEI_Baltimore[c("Emissions")], list(year = NEI_Baltimore$year, type = NEI_Baltimore$type), sum)
# but this one takes less typework:
aggEmission <- aggregate(Emissions ~ year + type, NEI_Baltimore, sum)


#****************************** Plot 3*************************************************************

qplot(year, Emissions, data=aggEmission, geom= "line", color = type) + 
      ggtitle("Total Emissions per year by type in Baltimore") + 
      xlab("Year") + ylab("Total PM2.5 Emissions") 

# save plot to png:
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()



