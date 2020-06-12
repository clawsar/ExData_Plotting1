## CHL
## 20200612
## Exploratory Data Analysis
## Project 1, Plot 4

## Clear workspace
rm(list=ls())

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
m.data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?",stringsAsFactors=FALSE)
unlink(temp)

## Combine date and time into a date-time stamp for all data
m.data$datetime <- strptime(paste(m.data$"Date", m.data$"Time"), format="%d/%m/%Y %H:%M:%OS")

## This dataset isn't too big, but in cases where the dataset alone will consume most of the RAM, let's strip out the unnecessary rows
## Find  the row that represents the start date-time
m.start <- min(which(m.data$datetime>="2007-02-01 00:00:00"))

## Find  the row that represents the end date-time.  Back up one row from this.  This avoids issues with rounding on time.
m.end <- min(which(m.data$datetime>="2007-02-03 00:00:00"))-1

m.data <- m.data[m.start:m.end,]

png("plot4.png", width=480, height=480, units="px")
	par(mfrow=c(2,2))
	plot(m.data$datetime, m.data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
	plot(m.data$datetime, m.data$Voltage, type="l", xlab="datetime", ylab="Voltage")
	plot(m.data$datetime, m.data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
	lines(m.data$datetime, m.data$Sub_metering_2, col="red")
	lines(m.data$datetime, m.data$Sub_metering_3, col="blue")
	legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),box.lty=0)
	plot(m.data$datetime, m.data$Global_reactive_power, type="l")
	
dev.off()