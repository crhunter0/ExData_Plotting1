## - This script creates a line graph for asssignment 1 of Exploratory Data Analysis

## - Read and filter data to only get the data needed for plot.
power <- fread("./household_power_consumption.txt", colClasses = 
                 list(character = 1:8))
power_2day <- power[grep("^((1/2/2007)|(2/2/2007))", power$Date),]

## - Convert Date column to a date class, combine with Time column to form datetime
power_2day$Date <- as.Date(power_2day$Date, format = "%d/%m/%Y")
datetime <- strptime(paste(power_2day$Date, power_2day$Time), 
                     format = "%Y-%m-%d %H:%M:%S")
power_dt <- cbind(power_2day, as.POSIXct(datetime))

## - create the plot as png file
png(file = "./plot3.png", width = 480, height = 480)
with(power_dt, plot(datetime, Sub_metering_1, type = "l", 
                    ylab = "Energy Sub Metering", xlab = ""))
with(power_dt, points(datetime, Sub_metering_2, col = "red", type = "l"))
with(power_dt, points(datetime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_Metering_1", 
          "Sub_Metering_2", "Sub_Metering_3"), lty = 1)
dev.off()

