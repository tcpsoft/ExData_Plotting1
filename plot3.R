## In this script we will read in a file, subset only the dates we want to 
## display, and create a stepped line graph of the three sub metering types

## Read in household power consumption data
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
png(filename = "plot3.png")

## Create frame for line graph
plot(elec_subset$datetime, elec_subset$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")

## Add lines to graph in step format
lines(elec_subset$datetime, elec_subset$Sub_metering_1, type = "s")
lines(elec_subset$datetime, elec_subset$Sub_metering_2, type = "s", col="RED")
lines(elec_subset$datetime, elec_subset$Sub_metering_3, type = "s", col="BLUE")

## Add a legend to the top right
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c('BLACK', 'RED', 'BLUE'), lty = 1)

## Close PNG device
dev.off()
