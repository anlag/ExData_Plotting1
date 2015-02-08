# this script reads data, processes it, and draws plot 3: a multiline plot of sub metered power over time

# read data frame from file
inData <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", na.strings = "?")

# filter out the two relevant days
twoDays <- inData[inData$Date == "1/2/2007" | inData$Date == "2/2/2007", ]

# create a new DateTime column containing both date and time in the POSIXlt class
twoDays$DateTime <- strptime(paste(twoDays$Date, twoDays$Time), format="%d/%m/%Y %H:%M:%S")

# convert the sub metering columns to numeric format
twoDays$Global_active_power <- as.numeric(twoDays$Global_active_power)
twoDays$Voltage <- as.numeric(twoDays$Voltage)
twoDays$Sub_metering_1 <- as.numeric(twoDays$Sub_metering_1)
twoDays$Sub_metering_2 <- as.numeric(twoDays$Sub_metering_2)
twoDays$Sub_metering_3 <- as.numeric(twoDays$Sub_metering_3)
twoDays$Global_reactive_power <- as.numeric(twoDays$Global_reactive_power)

# open the png device
png(file = "plot4.png")

# make a 2x2 multiplot figure
par(mfrow = c(2, 2))

# draw the first plot
plot(twoDays$DateTime, twoDays$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", main = "")

# draw the second plot
plot(twoDays$DateTime, twoDays$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", main = "")

# draw the third plot
plot(twoDays$DateTime, twoDays$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", main = "")
lines(twoDays$DateTime, twoDays$Sub_metering_1, col="black")
lines(twoDays$DateTime, twoDays$Sub_metering_2, col="red")
lines(twoDays$DateTime, twoDays$Sub_metering_3, col="blue")

legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# draw the fourth plot
plot(twoDays$DateTime, twoDays$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", main = "")

# close the file device
dev.off()