library(dplyr)
temp <- read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows = 5)

#This will speed up the reading of the data in the next line.
classes <- sapply(temp, class)  

elecData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses = classes, comment.char = "", na.strings = "?", nrows=2075259)

elecData$Date <- as.Date(elecData$Date, format="%d/%m/%Y")

startDate <- as.Date("2007-02-01", format="%Y-%m-%d")

endDate <- as.Date("2007-02-02", format="%Y-%m-%d")

elecData <- filter(elecData, Date == startDate | Date == endDate)

elecData <- mutate(elecData, dateTime = paste(Date, Time, sep = " "))

elecData$dateTime <- strptime(elecData$dateTime, format = "%Y-%m-%d %H:%M:%S")

png(file="plot2.png", width=480, height=480)

plot(elecData$dateTime, elecData$Global_active_power, xlab="", ylab="Global Active Power (Kilowatts)", type="l")

dev.off()