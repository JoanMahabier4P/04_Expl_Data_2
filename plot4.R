
#################################### Exploratory Data Analysis ##########################################

# Week 4: Assignment 2

# Question 4: 
# Across the US, how have emissions from coal combustion-related sources changed from 1999-2008?

#****************************** Preparations *************************************************************

# Clean up workspace
rm(list=ls())

library(datasets)

#****************************** Read data *************************************************************

# Read the unzipped files:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter data from coal combustion-related sources. The pattern matching is not case sensitive.
subCoal <- grepl("Coal" , SCC$Short.Name, ignore.case = TRUE)
CoalSCC <- SCC[subCoal,]

# lookup NEI rows by merging CoalSCC and NEI dataframes by common SCC-column
dfCoal <- merge(NEI, CoalSCC, by="SCC")

# Get total emissions per year
YearTotal <- aggregate(Emissions ~ year, dfCoal, sum)


#****************************** Plot 4 *************************************************************

barplot(height = YearTotal$Emissions, names.arg = YearTotal$year, xlab = "Year", ylab = "Total Emission (in tons)", 
        main = "Total Emissions from coal sources from 1999 to 2008")


# save plot to png:
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()



