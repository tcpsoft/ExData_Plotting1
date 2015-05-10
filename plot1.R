## In this script we will read in a file, subset only the dates we want to 
## display, and create a histogram of the Global Active Power data

## Read in household power consumption data
elec_data <- read.table("household_power_consumption.txt", 
header = TRUE, sep = ";", colClasses = c("character", 
"character", "numeric", "numeric", "numeric", "numeric", 
"numeric", "numeric", "numeric"), na.strings = "?")

## Select only two required dates
elec_subset <- subset(elec_data, Date %in% c("1/2/2007", "2/2/2007"))

## Set graphics device to png
png(filename = "plot1.png")

## Create histogram
hist(elec_subset$Global_active_power, xlab = "Global Active Power (kilowatts)",
  main = "Global Active Power", col = "RED")

## Close PNG device
dev.off()
