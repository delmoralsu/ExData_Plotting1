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
png(filename = "plot1.png", width=480, height=480)
## Plot the histogram
hist(table$globalactivepower, freq = TRUE, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
## Close device
dev.off()
## End! :)

