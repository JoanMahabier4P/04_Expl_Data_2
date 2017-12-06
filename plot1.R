
#################################### Exploratory Data Analysis ##########################################

# Week 4: Assignment 2

# Question 1: 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.


#****************************** Preparations *************************************************************

# Clean up workspace
rm(list=ls())

library(datasets)

#****************************** Read data *************************************************************

# Read the unzipped files:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get total emissions per year
YearTotal <- aggregate(Emissions ~ year, NEI, sum)

#****************************** Plot 1*************************************************************


barplot(height = YearTotal$Emissions, names.arg = YearTotal$year, xlab = "Year", ylab = "Total Emission (in tons)", 
        main = "Total Emission per year")

# save plot to png:
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()



