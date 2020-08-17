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
png(filename = "plot3.png", width=480, height=480)
## Plot the first variable (submetering1)
with(table, plot(datetime, submetering1, type = "l", xlab="",
                 ylab="Energy sub metering"))
## Plot the second variable (submetering2)
with(table, lines(datetime, submetering2, type = "l", col = "red"))
## Plot the third variable (submetering3)
with(table, lines(datetime, submetering3, type = "l", col = "blue"))
## Add the legend to the topright corner of the plot
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3"), col = c("black", "red",
                                                         "blue"), lty = 1)
## Close the grapics device
dev.off()

