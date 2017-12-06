
#################################### Exploratory Data Analysis ##########################################

# Week 4: Assignment 2

# Question 2: 
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 
# 1999 to 2008? Use the base plotting system to make a plot answering this question.


#****************************** Preparations *************************************************************

# Clean up workspace
rm(list=ls())

library(datasets)

#****************************** Read data *************************************************************

# Read the unzipped files:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter data from Baltimore City, Maryland 
NEI_Baltimore <- subset(NEI, fips == "24510")


# Get total emissions per year
YearTotal_Baltimore <- aggregate(Emissions ~ year, NEI_Baltimore, sum)

#****************************** Plot 2*************************************************************


barplot(height = YearTotal_Baltimore$Emissions, names.arg = YearTotal_Baltimore$year, xlab = "Year", ylab = "Total Emission (in tons)", 
        main = "Total Emission per year in Baltimore City")

# save plot to png:
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()



