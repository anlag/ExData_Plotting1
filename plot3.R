# this script reads data, processes it, and draws plot 3: a multiline plot of sub metered power over time

# read data frame from file
inData <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", na.strings = "?")

# filter out the two relevant days
twoDays <- inData[inData$Date == "1/2/2007" | inData$Date == "2/2/2007", ]

# create a new DateTime column containing both date and time in the POSIXlt class
twoDays$DateTime <- strptime(paste(twoDays$Date, twoDays$Time), format="%d/%m/%Y %H:%M:%S")

# convert the sub metering columns to numeric format
twoDays$Sub_metering_1 <- as.numeric(twoDays$Sub_metering_1)
twoDays$Sub_metering_2 <- as.numeric(twoDays$Sub_metering_2)
twoDays$Sub_metering_3 <- as.numeric(twoDays$Sub_metering_3)

# open the png device
png(file = "plot3.png")

# draw the line plot
plot(twoDays$DateTime, twoDays$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", main = "")
lines(twoDays$DateTime, twoDays$Sub_metering_1, col="black")
lines(twoDays$DateTime, twoDays$Sub_metering_2, col="red")
lines(twoDays$DateTime, twoDays$Sub_metering_3, col="blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close the file device
dev.off()