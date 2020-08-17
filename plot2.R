file <- "household_power_consumption.txt"
table <- read.table(text = grep("^[1/2]/2/2007", readLines(file), value = TRUE),
                    col.names = c("date", "time", "globalactivepower",
                                  "globalreactivepower", "voltage", "globalintensity"
                                  , "submetering1", "submetering2", "submetering3"),
                    sep = ";", na.strings = "?")
table$datetime <- as.character(paste(table$date, table$time))
table$datetime <- as.POSIXct(table$datetime, format = "%d/%m/%Y %H:%M:%OS")
png(filename = "plot2.png",  width=480, height=480)
plot(table$datetime, table$globalactivepower, type = "l", xlab="",
     ylab = "Global Active Power (kilowatts)")
dev.off()
