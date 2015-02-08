# this script reads data, processes it, and draws plot 1: a global active power histogram

# read data frame from file
inData <- read.csv("household_power_consumption.txt", sep = ";", colClasses = "character", na.strings = "?")

# filter out the two relevant days
twoDays <- inData[inData$Date == "1/2/2007" | inData$Date == "2/2/2007", ]

# convert the Global_active_power column to numeric format
twoDays$Global_active_power <- as.numeric(twoDays$Global_active_power)

# open the png device
png(file = "plot1.png")

# plot the histogram
hist(twoDays$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

# close the file device
dev.off()