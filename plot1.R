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
png(filename = "plot1.png")
with(hpc, hist(Global_active_power, col = "red", xlab = "Global active power (kilowatts)", main = "Global Active Power"))
dev.off()
