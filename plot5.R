
#################################### Exploratory Data Analysis ##########################################

# Week 4: Assignment 2

# Question 5: 
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


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

# filter data from motor vehicle-related sources. The pattern matching is not case sensitive.
subVehicle  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VehicleSCC <- SCC[subVehicle,]

# lookup NEI rows by merging dfCoal and NEI datatframes by common SCC-column
dfVehicle <- merge(NEI_Baltimore, VehicleSCC, by="SCC")

# Get total emissions per year
YearTotal_Baltimore <- aggregate(Emissions ~ year, dfVehicle, sum)


#****************************** Plot 5 *************************************************************


barplot(height = YearTotal_Baltimore$Emissions, names.arg = YearTotal_Baltimore$year, xlab = "Year", ylab = "Total Emission (in tons)", 
        main = "Total Emission per year motor vehicle sources in Baltimore City")

# save plot to png:
dev.copy(png, file = "plot5.png", width = 480, height = 480)
dev.off()



