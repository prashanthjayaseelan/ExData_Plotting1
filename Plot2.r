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
png("plot2.png",width=480, height=480)
par(mfcol=c(1,1))
plot(a$datetime,as.numeric(a$Global_active_power),xlab = "", ylab = "Global Active Power(kilowatts)", type="l")
dev.off()
