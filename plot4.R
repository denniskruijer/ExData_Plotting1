# Retrieve relevant data
my_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
my_data$Date <- as.Date(my_data$Date, "%d/%m/%Y")
my_data <- subset(my_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
my_data <- my_data[complete.cases(my_data),]
dateTime <- paste(my_data$Date, my_data$Time)
dateTime <- setNames(dateTime, "DateTime")
my_data <- my_data[ ,!(names(my_data) %in% c("Date","Time"))]
my_data <- cbind(dateTime, my_data)
my_data$dateTime <- as.POSIXct(dateTime)

# Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1))

# Plot 4a
plot(my_data$Global_active_power~my_data$dateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot 4b
plot(my_data$Voltage~my_data$dateTime, type = "l", xlab = "", ylab = "Voltage (volt)")

# Plot 4c (copy Plot 3)
plot(my_data$Sub_metering_1~my_data$dateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(my_data$Sub_metering_2~my_data$dateTime, type = "l", col = "red")
lines(my_data$Sub_metering_3~my_data$dateTime, type = "l", col = "blue")
legend("topright", legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), col = c("black", "red", "blue"), lwd = c(1,1,1))

# Plot 4d
plot(my_data$Global_reactive_power~my_data$dateTime, type = "l", xlab = "", ylab = "Global Reactive Power (kilowatts)")
dev.copy(png, "plot4.png", width=480, height=480)
dev.off()
