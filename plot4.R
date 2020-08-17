## IMPORTANT: household_power_consumption.txt must be present in the working
## directory.

file <- "household_power_consumption.txt"
## Read the table for only the dates needed (February 1 and February 2 2007)
table <- read.table(text = grep("^[1/2]/2/2007", readLines(file), value = TRUE),
                    col.names = c("date", "time", "globalactivepower",
                                  "globalreactivepower", "voltage",
                                  "globalintensity", "submetering1",
                                  "submetering2", "submetering3"),
                    sep = ";", na.strings = "?")
## Combine the time and date columns into just one column, of the correct class
table$datetime <- as.character(paste(table$date, table$time))
table$datetime <- as.POSIXct(table$datetime, format = "%d/%m/%Y %H:%M:%OS")
## Open the graphics device and assign a filename and its corresponding height
## and width
png(filename = "plot4.png", width=480, height=480)
## Set the 2x2 distribution of plots
par(mfrow=c(2,2))
## First plot
with(table, plot(datetime, globalactivepower, ylab="Global Active Power",
                 xlab="", type="l"))
## Second plot
with(table, plot(datetime, voltage, ylab="Voltage", type="l"))
## Third plot
with(table, c(plot(datetime, submetering1, type = "l", xlab="",
                   ylab="Energy sub metering"),
              lines(datetime, submetering2, type = "l", col = "red"),
              lines(datetime, submetering3, type = "l", col = "blue"),
              legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                                            "Sub_metering_3"), col = c("black",
                                                                       "red",
                                                                       "blue"),
                     lty = 1, bty = "n")))
## Fourth plot
with(table, plot(datetime, globalreactivepower, ylab="Global_reactive_power",
                 type="l"))
## Close device
dev.off()
## End! :)
