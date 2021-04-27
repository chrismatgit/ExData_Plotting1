library("data.table")

setwd("/root/Documents/R/ExData_Plotting1/")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# Prevents histogram from printing in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


# Filter Dates for 2007-02-01 and 2007-02-03
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-03")]

png("plot4.png", width=500, height=500)

par(mfrow=c(2,2))

# Plot 1
plot(powerDT[, dateTime], powerDT[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(powerDT[, dateTime], powerDT[, Voltage], type = "l", xlab = "Datetime", ylab = "Voltage")

# Plot 3
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2], col = "red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3], col = "blue")

# Plot 4
plot(powerDT[, dateTime], powerDT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()