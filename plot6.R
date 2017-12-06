
#################################### Exploratory Data Analysis ##########################################

# Week 4: Assignment 2

# Question 6: 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#****************************** Preparations *************************************************************

# Clean up workspace
rm(list=ls())

library(ggplot2)

#****************************** Read data *************************************************************

# Read the unzipped files:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter data from Baltimore and Los Angeles
NEI_Baltimore <- subset(NEI, fips == "24510")
NEI_LA <- subset(NEI, fips == "06037")

# filter data from motor vehicle-related sources. The pattern matching is not case sensitive.
subVehicle  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VehicleSCC <- SCC[subVehicle,]

# lookup NEI_Baltimore rows by merging VehicleSCC and NEI_Baltimore dataframes by common SCC-column
dfVehicle_Balt <- merge(NEI_Baltimore, VehicleSCC, by="SCC")
# Add column city to dataframe to get the name of the city in the plot rather than the fipsnumber
dfVehicle_Balt$city <- "Baltimore"

# lookup NEI_LA rows by merging VehicleSCC and NEI_LA dataframes by common SCC-column
dfVehicle_LA <- merge(NEI_LA, VehicleSCC, by="SCC")
# Add column city to dataframe to get the name of the city in the plot rather than the fipsnumber
dfVehicle_LA$city <- "Los Angeles"

# Make one dataframe for both cities
df <- rbind(dfVehicle_Balt, dfVehicle_LA)

# Get total emissions per year per city
aggEmission <- aggregate(Emissions ~ year + city, df, sum)


#****************************** Plot 6 *************************************************************

g <- ggplot(aggEmission, aes(year, Emissions, color = city))
g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from motor sources in Baltimore and LA")

# save plot to png:
dev.copy(png, file = "plot6.png", width = 550, height = 480)
dev.off()



