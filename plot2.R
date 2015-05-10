## In this script we will read in a file, subset only the dates we want to 
## display, and create a stepped line graph of the Global Active Power 

## Read in the household power consumption data
## This script leaves date and time in char format for the time being
## to be converted and concatenated into a single column in a later step

elec_data <- read.table("household_power_consumption.txt", header = TRUE, 
  sep = ";", colClasses = c("character", "character", "numeric", "numeric", 
  "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

## Select only two required dates
elec_subset <- subset(elec_data, Date %in% c("1/2/2007", "2/2/2007"))

## Create a variable to concatenate the date and time string fields
mydatetime <- paste(elec_subset$Date, elec_subset$Time)

## Add a new column called datetime to the dataframe containing the 
## concatenated values converted to POSIXlt and POSIXt
elec_subset$datetime <- strptime(mydatetime, "%d/%m/%Y %H:%M:%S")

## Set graphics device to png
png(filename = "plot2.png")

## Create frame for line graph
plot(elec_subset$datetime, elec_subset$Global_active_power, type = "n", 
  xlab = "", ylab = "Global Active Power (kilowatts)")

## Add lines to graph in step format
lines(elec_subset$datetime, elec_subset$Global_active_power, type = "s")

## Close the PNG device
dev.off()
