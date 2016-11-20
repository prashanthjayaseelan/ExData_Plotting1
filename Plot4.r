library(dplyr)
library(lubridate)
# download the source dataset and decompress using unzip.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="ElectricData.zip")
unzip("ElectricData.zip")

#Read the file into R and convert "?" to NA.
hp=read.table("household_power_consumption.txt",sep=";",header = TRUE, na.strings = "?")

#Filter just the records needed as per the instructions from the instructor.
hp$dt=as.Date(hp$Date,"%d/%m/%Y")
a=filter(hp,hp$dt==as.Date("2007-02-02")|hp$dt==as.Date("2007-02-01"))
a$datetime = strptime(paste(a$Date,a$Time),"%d/%m/%Y %H:%M:%S")

#Set the device to be a png file with requested size and plot.
png("plot4.png",width=480, height=480)
par(mfcol=c(2,2))
plot(a$datetime,as.numeric(a$Global_active_power),xlab = "", ylab = "Global Active Power(kilowatts)", type="l")
plot(a$datetime,as.numeric(a$Sub_metering_1),type="l",xlab="",ylab="Energy sub metering")
lines(a$datetime,as.numeric(a$Sub_metering_2),type="l",col="red")
lines(a$datetime,as.numeric(a$Sub_metering_3),type="l",col="blue")
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(a$datetime,a$Voltage,type="l",xlab = "datetime", ylab="Voltage")
plot(a$datetime,as.numeric(a$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()