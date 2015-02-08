# this script reads data, processes it, and draws plot 2: a line plot of global active power over time

# read data frame from file
inData <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", na.strings = "?")

# filter out the two relevant days
twoDays <- inData[inData$Date == "1/2/2007" | inData$Date == "2/2/2007", ]

# create a new DateTime column containing both date and time in the POSIXlt class
twoDays$DateTime <- strptime(paste(twoDays$Date, twoDays$Time), format="%d/%m/%Y %H:%M:%S")

# convert the Global_active_power column to numeric format
twoDays$Global_active_power <- as.numeric(twoDays$Global_active_power)

# open the png device
png(file = "plot2.png")

# draw the line plot
plot(twoDays$DateTime, twoDays$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", main = "")

# close the file device
dev.off()