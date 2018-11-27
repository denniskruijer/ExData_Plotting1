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

# Plot 1
hist(my_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()