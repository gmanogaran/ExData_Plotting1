library(lubridate)
library(ggplot2)
library(data.table)
library(reshape2)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zfPath <- file.path(path, "household_power_consumption.zip")
zfPath
if(!file.exists(zfPath)){
  download.file(url, zfPath)
  unzip(zfPath)
}
fPath <- file.path(path, "household_power_consumption.txt")
hpc <- data.table(read.table(fPath, sep = ";", header = TRUE, na.strings = "?"))
hpc <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")
hpc$datetime <- paste(hpc$Date, hpc$Time)
hpc$datetime <- dmy_hms(hpc$datetime)
dim(hpc)
png(filename = "plot3.png")
with(hpc, plot(Sub_metering_1~datetime, type="l", ylab="Energy sub metering", xlab=""))
with(hpc, lines(Sub_metering_2~datetime, type="l", col='Red'))
with(hpc, lines(Sub_metering_3~datetime, type="l", col='Blue'))
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
