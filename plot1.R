## - This script creates a histogram for asssignment 1 of Exploratory Data Analysis

## - Read and filter data to only get the data needed for plot.
power <- fread("./household_power_consumption.txt", colClasses = 
                 list(character = 1:8))
power_2day <- power[grep("^((1/2/2007)|(2/2/2007))", power$Date),]

## - Convert Date column to a date class, combine with Time column to form datetime
power_2day$Date <- as.Date(power_2day$Date, format = "%d/%m/%Y")
datetime <- strptime(paste(power_2day$Date, power_2day$Time), 
                     format = "%Y-%m-%d %H:%M:%S")
power_dt <- cbind(power_2day, as.POSIXct(datetime))

## - convert to numeric for plotting
power_2day$Global_active_power <- as.numeric((power_2day$Global_active_power))

## - create the plot as png file

png(file = "./plot1.png", width = 480, height = 480)
hist(power_2day$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

