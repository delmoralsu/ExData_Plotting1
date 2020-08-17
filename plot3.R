file <- "household_power_consumption.txt"
table <- read.table(text = grep("^[1/2]/2/2007", readLines(file), value = TRUE),
                    col.names = c("date", "time", "globalactivepower",
                                  "globalreactivepower", "voltage", "globalintensity"
                                  , "submetering1", "submetering2", "submetering3"),
                    sep = ";", na.strings = "?")
table$datetime <- as.character(paste(table$date, table$time))
table$datetime <- as.POSIXct(table$datetime, format = "%d/%m/%Y %H:%M:%OS")
png(filename = "plot3.png", width=480, height=480)
with(table, plot(datetime, submetering1, type = "l", xlab="", ylab="Energy sub metering"))
with(table, lines(datetime, submetering2, type = "l", col = "red"))
with(table, lines(datetime, submetering3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()

